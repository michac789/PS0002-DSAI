"
PS0002 Project
"

### Load all required packages ###
library(dplyr) # for data wrangling
library(ggplot2) # for data visualization
library(gridExtra) # for combining several graphs
library(caret) # for regression training
library(corrplot) # for displaying correlation matrix
library(class) # for knn classification
library(e1071) # for svc classifier

### Load Dataset & Understanding Dataset ###
# type your working directory containing file_name here
current_dir <- "C:/My Files/MY REPOSITORIES/PS0002/project"
# type csv file name containing dataset
file_name <- "dataset.csv"
# set current working directory, move into dataframe
setwd(current_dir)
# read csv file, store into data frame 'df'
df <- read.csv(file_name, header = T, sep = ";", fileEncoding = "UTF-8-BOM")
# understanding dataset
dim(df) # show dimension
names(df) # show all variable (column) names
head(df, 10) # show first 10 data
summary(df) # show short summary of all column
str(df) # show each variable types and values

### Data Wrangling ###
# check if there is any NA values
table(is.na(df))
# verify that only the last column (MOTM) has NA value, the rest has no NA
table(is.na(select(df, -MOTM)))
# if last column (MOTM) is NA, place the value 0 instead, else it is 1
df[is.na(df)] <- 0
table(is.na(df))
# select all column (except the first 4 columns: date, name, day, venue)
# that has only numbers but still in string format
target <- as.character(names(df %>% select(where(is.character) & 5:ncol(df))))
target
# for all of these columns, we want to convert from chr to numeric type
for (col in target) {
    # get the index number of the column name
    col_index <- grep(paste("^", col, "$", sep = ""), colnames(df))
    # for each column, replace ',' to '.' then convert to numeric
    df[, col_index] <- as.numeric(gsub(",", ".", df[, col_index]))
}
# remove data if rating is 0 (invalid), change to 0 for other NA values
# note: these NA are caused by some rows of the column Cmp. in target that was
# empty string (chr, not NA), but resulting in NA when converted to numeric
dim(df)
df <- df %>% filter(Rating != 0)
df[is.na(df)] <- 0
dim(df)
str(df) # check

### Exploratory Data Analysis ###
# we claim that date and day has no effect to rating or MOTM
# we are also not interested in name column (too much player names)
# drop first three column (date, name, Day)
df <- df[, 4:ncol(df)]
# we want to investigate whether if venue affect rating or MOTM?
# display average rating and MOTM rate for each venue group
df %>%
    select(Venue, Rating, MOTM) %>%
    group_by(Venue) %>%
    summarise(count = n(), avRating = mean(Rating), MOTM = sum(MOTM)) %>%
    mutate(MOTM_rate = MOTM / count)
# visualize density curves to show rating distribution
par(mfrow = c(1, 1))
ggplot(df, aes(Rating)) + geom_density(color = "magenta", fill = "lightpink") +
    geom_vline(aes(xintercept = mean(Rating)), color = "brown")
# visualize rating distribution count using histogram
ggplot(df, aes(Rating)) + geom_histogram()
# visualize rating on different venues side by side using boxplot
boxplot(filter(df, Venue == "Home")$Rating, filter(df, Venue == "Away")$Rating,
    names = c("Home", "Away"), ylab = "Rating", xlab = "Venue",
    col = c("Lightblue", "Lightgreen"))
# venue also has very insignificant effect, so we drop this column
df <- df[, 2:ncol(df)]
# scatter plot relationships of various potential predictors with rating
predictors <- colnames(df[, 1:(ncol(df) - 2)])
pp <- list()
for (i in seq(1, length(predictors))) {
    pp[[i]] <- ggplot(df, aes_string(x = predictors[i], y = "Rating")) +
        geom_point() + geom_smooth(method = "lm")
}
do.call(grid.arrange, pp)
# box plot relationships for each MOTM (0 and 1) with various predictors
pp2 <- list()
for (i in seq(1, length(predictors))) {
    pp2[[i]] <- ggplot(df, aes_string(x = "MOTM", y = predictors[i],
        fill = "factor(MOTM)")) + geom_boxplot()
}
do.call(grid.arrange, pp2)
# violin plot relationships for each MOTM (0 and 1) with various predictors
pp3 <- list()
for (i in seq(1, length(predictors))) {
    pp3[[i]] <- ggplot(df, aes_string(x = "MOTM", y = predictors[i],
        fill = "factor(MOTM)")) + geom_point() + geom_violin()
}
do.call(grid.arrange, pp3)
# boxplot and bar chart (for discrete predictor: 2, 3, 4, 5, 8, 9, 19)
pp4 <- list()
for (i in seq(1, length(predictors))) {
    if (i %in% c(2, 3, 4, 5, 8, 9, 19)) {
        df_tmp <- rbind(
            df %>%
                select(contains(predictors[i]), MOTM) %>%
                group_by(across(1)) %>%
                summarise(MOTM_tot = sum(MOTM), count = n()) %>%
                mutate(rate = MOTM_tot / count, MOTM = "TRUE"),
            df %>%
                select(contains(predictors[i]), MOTM) %>%
                group_by(across(1)) %>%
                summarise(MOTM_tot = sum(MOTM), count = n()) %>%
                mutate(rate = 1 - MOTM_tot / count, MOTM = "FALSE")
        )
        pp4[[i]] <- ggplot(df_tmp, aes_string(x = predictors[i],
            y = "rate", fill = "MOTM")) + geom_bar(stat = "identity")
    } else {
        pp4[[i]] <- ggplot(df, aes_string(x = "MOTM", y = predictors[i],
            fill = "factor(MOTM)")) + geom_boxplot()
    }
}
do.call(grid.arrange, pp4)
# display correlation plot
corrplot(cor(df[, seq(1, ncol(df))]), type = "upper",
    method = "color", addCoef.col = "black", number.cex = 0.4)
# display as a row corrplot of rating against various predictor
corrplot(cor(df[, seq(1, ncol(df))])[ncol(df) - 1, seq(1, ncol(df) - 1),
    drop = FALSE], method = "color", addCoef.col = "black",
    type = "upper", number.cex = 0.8)
# potential 2nd order term: Gls, SoT, Touches, xG, SCA, Carries
# qqplot
par(mfrow = c(1, 1))
qqnorm(df$Rating)
qqline(df$Rating)

### Split Training & Testing Set ###
# remove crdY for regression as it has very low correlation
# df_regr to predict rating, df_clas to predict MOTM
df_regr <- select(df, -MOTM, -CrdY)
df_clas <- select(df, -Rating)
# make sure the data is selected properly
names(df_regr)
dim(df_regr)
head(df_regr)
names(df_clas)
dim(df_clas)
head(df_clas)
# ensure us to get the same result
set.seed(100)
# split into 80% training data, 20% testing data
regr_training_id <- sample(seq(1, nrow(df_regr)), nrow(df_regr) * 0.8)
regr_train_data <- df_regr[regr_training_id, ]
regr_test_data <- df_regr[-regr_training_id, ]
clas_training_id <- sample(seq(1, nrow(df_clas)), nrow(df_clas) * 0.8)
clas_train_data <- df_clas[clas_training_id, ]
clas_test_data <- df_clas[-clas_training_id, ]

### Linear Regression ###
# perform initial linear regression and print summary
lmodel1 <- lm(Rating ~ ., data = regr_train_data)
summary(lmodel1)
summary(lmodel1)$adj.r.squared # 0.8139
# assess model performance by predicting test data, plot graph, print RMSE
predictionslm <- predict(lmodel1, regr_test_data)
par(mfrow = c(1, 1))
plot(regr_test_data$Rating, predictionslm, col = "blue",
    xlab = "Real Rating (Test Data)", ylab = "Predicted Rating")
abline(0, 1, col = "red")
RMSE(predictionslm, regr_test_data$Rating) # 0.3516
# display residual plot, qqplot, check for outlier
par(mfrow = c(2, 2))
plot(lmodel1) # outliers: 2367
# remove outliers from data and resample
df_regr2 <- df_regr[-c(2367), ]
set.seed(100)
regr_training_id2 <- sample(seq(1, nrow(df_regr)), nrow(df_regr) * 0.8)
regr_train_data2 <- df_regr2[regr_training_id2, ]
regr_test_data2 <- df_regr2[-regr_training_id2, ]
# add second order based where |r|>0.5: Gls, SoT, Touches, xG, SCA, Carries
lmodel2 <- lm(Rating ~ . + I(Gls ^ 2) + I(SoT ^ 2) + I(Touches ^ 2) +
    I(xG ^ 2) + I(SCA ^ 2) + I(Carries ^ 2), data = regr_train_data2)
summary(lmodel2)
summary(lmodel2)$adj.r.squared # 0.8210
# assess 2nd linear model performance
predictionslm2 <- predict(lmodel2, regr_test_data2)
par(mfrow = c(1, 1))
plot(regr_test_data2$Rating, predictionslm2, col = "blue",
    xlab = "Real Rating (Test Data)", ylab = "Predicted Rating")
abline(0, 1, col = "red")
RMSE(predictionslm2, regr_test_data2$Rating) # 0.3482
par(mfrow = c(2, 2))
plot(lmodel2)
# choose lmodel2 that has lower RMSE & better rsquared compared to lmodel1

### KNN Regression ###
set.seed(101)
# cross validation sampling with around 40-50 sample each group
cv_count <- floor(nrow(regr_train_data) / 45)
cv_count
# number of k to tune
k_count <- 10
# using knn regression; output: MOTM, inputs: all the other variables
# normalize the data and perform knn regression
knnregr_model <- train(
    Rating ~ ., data = regr_train_data, method = "knn",
    trControl = trainControl("cv", number = cv_count),
    preProcess = c("center", "scale"),
    tuneLength = k_count
)
# plot the different k values
plot(knnregr_model)
knnregr_model$bestTune # best k = 11
# predict test data, show rmse
regr_knn_predictions <- as.numeric(predict(knnregr_model, regr_test_data))
head(regr_knn_predictions)
RMSE(regr_knn_predictions, regr_test_data$Rating) # 0.4158
# plot of predicted values vs real values
par(mfrow = c(1, 1))
plot(regr_test_data$Rating, regr_knn_predictions, col = "blue",
    main = "KNN Regression Prediction")
abline(0, 1, col = "#f9018d")
# define rsquared function taking 2 vector inputs
rsq <- function(x, y) {
    return(cor(x, y) ^ 2)
}
rsq(regr_test_data$Rating, regr_knn_predictions) # 0.7565
# clearly knn regression is worse than linear regression, pick lmodel2

### Logistic Regression Classifier ###
# function that accepts confusion matrix object and return f1 as our metric
extractf1 <- function(str) {
    start <- regexpr("F1", str[4])[[1]]
    val <- substr(str[4], start + 5, start + 10)
    val <- substr(val, 1, ifelse(regexpr(",", val)[[1]] == -1,
        6, regexpr(",", val)[[1]] - 1))
    return(format(round(as.numeric(val), 4), nsmall = 4))
}
# perform logistic regression using binomial family, show summary
set.seed(100)
logreg_model <- glm(MOTM ~ ., data = clas_train_data, family = "binomial")
summary(logreg_model)
# initialize new dataframe to store various cutoff results
logreg_metrics <- data.frame()
# loop cutoff from 0.02 to 0.98 with step of 0.02
for (cutoff in seq(0.02, 0.98, 0.02)) {
    # predict outcome based on test data, test with various cutoff level
    logreg_predictions <- ifelse(predict(logreg_model,
        newdata = clas_test_data, type = "response") > cutoff, 1, 0)
    # overall accuracy, confusion matrix table
    ovrl <- mean(logreg_predictions == clas_test_data$MOTM)
    cm_logreg <- table(logreg_predictions, clas_test_data$MOTM)
    # store confusion matrix object here
    cm_data <- confusionMatrix(as.factor(logreg_predictions),
        as.factor(clas_test_data$MOTM), mode = "everything", positive = "1")
    # for every cutoff level, store metrics in logreg_metrics data frame
    logreg_metrics <- rbind(logreg_metrics, c(
        cutoff, extractf1(cm_data), format(round(ovrl, 4), nsmall = 4),
        format(round(specificity(cm_logreg), 4), nsmall = 4),
        format(round(sensitivity(cm_logreg), 4), nsmall = 4)))
    # note: we purposely exchange spec and sens here, as we assume '1' is
    # positive, while '0' is negative
}
colnames(logreg_metrics) <- c("cutoff", "f1score", "overall", "sens", "spec")
head(logreg_metrics)
dim(logreg_metrics)
attach(logreg_metrics)
# pick row with highest f1score from logreg_metrics data frame
best <- logreg_metrics[which.max(f1score), ] # f1score 0.5333
best # get best cutoff = 0.44
# overall accuracy = 0.9501, sensitivity = 0.5588, specificity = 0.9799
# display confusion matrix with this cutoff = 0.1
logreg_predictions <- ifelse(predict(logreg_model, newdata = clas_test_data,
    type = "response") > as.numeric(best$cutoff), 1, 0)
confusionMatrix(as.factor(logreg_predictions),
    as.factor(clas_test_data$MOTM), mode = "everything", positive = "1")
# plot different cutoff with various metrics
dfnew <- rbind(
    logreg_metrics %>%
        select(cutoff, f1score) %>%
        mutate(metric = "f1score") %>%
        rename(val = f1score),
    logreg_metrics %>%
        select(cutoff, overall) %>%
        mutate(metric = "overall") %>%
        rename(val = overall),
    logreg_metrics %>%
        select(cutoff, sens) %>%
        mutate(metric = "sens") %>%
        rename(val = sens),
    logreg_metrics %>%
        select(cutoff, spec) %>%
        mutate(metric = "spec") %>%
        rename(val = spec))
dfnew <- transform(dfnew, cutoff = as.numeric(cutoff), val = as.numeric(val))
ggplot(dfnew, aes(x = cutoff, y = val, group = metric)) +
    geom_line(aes(color = metric)) + geom_point(aes(color = metric)) +
    theme(axis.line = element_line(colour = "darkblue", size = 1,
    linetype = "solid")) + labs(title = "Cutoff - Metrics Comparison")

### KNN Classification ###
# convert last column (MOTM) to factor type
clas_train_data2 <- mutate(clas_train_data, MOTM = factor(MOTM))
clas_test_data2 <- mutate(clas_test_data, MOTM = factor(MOTM))
# it is obvious that since class of MOTM is unbalanced, there would be very few
# true positive, and sensitivity would be too low, hence f1score is bad
# we sample out some train data with MOTM = 0 to make better model
# make 2 dataframe storing training set with motm == 0 (n) and motm == 1(y)
dim(clas_train_data2)
clas_train_data2_n <- filter(clas_train_data2, MOTM == 0)
clas_train_data2_y <- filter(clas_train_data2, MOTM == 1)
nrow(clas_train_data2_n)
nrow(clas_train_data2_y)
knnclas_metrics <- data.frame()
# loop through different p (percentage of train data with motm == 0 used)
for (p in seq(0.05, 1, 0.05)) {
    # use only p percent training data with motm == 0
    set.seed(100)
    clas_train_data2_n_id <- sample(seq(1, nrow(clas_train_data2_n)),
        nrow(clas_train_data2_n) * p)
    clas_train_data2_n_used <- clas_train_data2_n[clas_train_data2_n_id, ]
    clas_train_data_used <- rbind(clas_train_data2_n_used, clas_train_data2_y)
    # ratio of training set with motm == 0 to motm == 1
    ratio <- nrow(clas_train_data2_n_used) / nrow(clas_train_data2_y)
    # cross-validation count (divide about 40-50 sample per group)
    set.seed(101)
    cv_count2 <- floor(nrow(clas_train_data_used) / 45)
    # train the model
    knnclas_model <- train(
        MOTM ~ ., data = clas_train_data_used, method = "knn",
        trControl = trainControl("cv", number = cv_count2),
        preProcess = c("center", "scale"),
        tuneLength = 15
    )
    # predict from model
    knnclas_predictions <- predict(knnclas_model, clas_test_data2)
    table(knnclas_predictions)
    # overall accuracy, confusion matrix table
    ovrl <- mean(knnclas_predictions == clas_test_data2$MOTM)
    cm_knnclas <- table(knnclas_predictions, clas_test_data2$MOTM)
    # store confusion matrix object here
    cm_data <- confusionMatrix(as.factor(knnclas_predictions),
        as.factor(clas_test_data2$MOTM), mode = "everything", positive = "1")
    # for every sampling level, store metrics in logreg_metrics data frame
    knnclas_metrics <- rbind(knnclas_metrics, c(
        p, format(round(ratio, 4), nsmall = 4), knnclas_model$bestTune[1, 1],
        extractf1(cm_data), format(round(ovrl, 4), nsmall = 4),
        format(round(specificity(cm_knnclas), 4), nsmall = 4),
        format(round(sensitivity(cm_knnclas), 4), nsmall = 4)))
}
colnames(knnclas_metrics) <- c("p", "ratio", "best_k",
    "f1score", "overall", "sens", "spec")
head(knnclas_metrics)
dim(knnclas_metrics)
# pick row with highest f1score from knnclas_metrics data frame
bestknn <- knnclas_metrics[which.max(knnclas_metrics$f1score), ]
# f1score 0.4878
bestknn # get best p = 0.1, k = 25
# overall accuracy = 0.8482, sensitivity = 0.8529, specificity = 0.8479
# plot different p with various metrics
dfnew2 <- rbind(
    knnclas_metrics %>%
        select(p, f1score) %>%
        mutate(metric = "f1score") %>%
        rename(val = f1score),
    knnclas_metrics %>%
        select(p, overall) %>%
        mutate(metric = "overall") %>%
        rename(val = overall),
    knnclas_metrics %>%
        select(p, sens) %>%
        mutate(metric = "sens") %>%
        rename(val = sens),
    knnclas_metrics %>%
        select(p, spec) %>%
        mutate(metric = "spec") %>%
        rename(val = spec))
dfnew2 <- transform(dfnew2, p = as.numeric(p), val = as.numeric(val))
ggplot(dfnew2, aes(x = p, y = val, group = metric)) +
    geom_line(aes(color = metric)) + geom_point(aes(color = metric)) +
    theme(axis.line = element_line(colour = "#1f7140", size = 1,
    linetype = "solid")) + labs(title = "KNN Classification")
# recreate of final model that we used (p = 0.1)
p <- 0.1
set.seed(100)
clas_train_data2_n_id <- sample(seq(1, nrow(clas_train_data2_n)),
    nrow(clas_train_data2_n) * p)
clas_train_data2_n_used <- clas_train_data2_n[clas_train_data2_n_id, ]
clas_train_data_used <- rbind(clas_train_data2_n_used, clas_train_data2_y)
ratio <- nrow(clas_train_data2_n_used) / nrow(clas_train_data2_y)
set.seed(101)
cv_count2 <- floor(nrow(clas_train_data_used) / 45)
knnclas_model <- train(
    MOTM ~ ., data = clas_train_data_used, method = "knn",
    trControl = trainControl("cv", number = cv_count2),
    preProcess = c("center", "scale"),
    tuneLength = 15
)
# display model summary and confusion matrix
knnclas_model
knnclas_predictions <- predict(knnclas_model, clas_test_data2)
table(knnclas_predictions)
ovrl <- mean(knnclas_predictions == clas_test_data2$MOTM)
cm_knnclas <- table(knnclas_predictions, clas_test_data2$MOTM)
confusionMatrix(as.factor(knnclas_predictions),
    as.factor(clas_test_data2$MOTM), mode = "everything", positive = "1")

### Support Vector Machine ###
# convert MOTM output into factor data type
clas_train_output <- as.factor(clas_train_data$MOTM)
# remove MOTM column from training data, leaving only predictors
clas_train_data2 <- clas_train_data[-ncol(clas_train_data)]
# perform svc with linear kernel function hyperplane
svm_model_lin <- svm(clas_train_output ~ .,
    data = clas_train_data2, kernel = "linear")
summary(svm_model_lin)
# predict the outcome
svm_pred_lin <- predict(svm_model_lin, clas_test_data[, -ncol(clas_test_data)])
# display confusion matrix, overall accuracy
mean(svm_pred_lin == clas_test_data$MOTM)
cm_svclin <- table(svm_pred_lin, clas_test_data$MOTM)
cm_svclin
# display sensitivity and specificity
sensitivity(cm_svclin)
specificity(cm_svclin)
# try other kernel functions as well
svm_model_rad <- svm(clas_train_output ~ ., # radial
    data = clas_train_data2, kernel = "radial")
summary(svm_model_rad)
svm_pred_rad <- predict(svm_model_rad, clas_test_data[, -ncol(clas_test_data)])
mean(svm_pred_rad == clas_test_data$MOTM)
table(svm_pred_rad, clas_test_data$MOTM)
svm_model_sig <- svm(clas_train_output ~ ., # sigmoid
    data = clas_train_data2, kernel = "sigmoid")
summary(svm_model_rad)
svm_pred_sig <- predict(svm_model_sig, clas_test_data[, -ncol(clas_test_data)])
mean(svm_pred_sig == clas_test_data$MOTM)
table(svm_pred_sig, clas_test_data$MOTM)

### Clustering ###
# select all predictors only to be clustered
df_clus <- select(df, -Rating, -MOTM)
# normalize all variables
df_clus_norm <- scale(df_clus)
head(df_clus_norm)
# find optimal k for kmeans clustering using elbow method
wcss <- function(k) {
    kmeans(df_clus_norm, k, nstart = 10)$tot.withinss
}
k_values <- 1:15
set.seed(100)
wcss_k <- sapply(k_values, wcss)
# plot to gain k = 7
plot(k_values, wcss_k, type = "b", pch = 19, frame = F,
    xlab = "Number of clusters K",
    ylab = "Total within-cluster sum of squares")
# perform kmeans clustering
kclus <- kmeans(df_clus_norm, centers = 7, nstart = 25)
str(kclus)
df_clus2 <- df_clus %>%
    mutate(cluster = kclus$cluster) %>%
    group_by(cluster)
# display summary for every cluster
summarize(df_clus2, count = n())
summarise_all(df_clus2, "mean")
# dissimilarity matrix (warning: please do NOT print it)
dismat <- dist(df_clus_norm, method = "euclidean")
# perform hierarchical clustering
hierclus <- hclust(dismat, method = "complete", members = NULL)
hierclus
# plot dendogram and draw colored border of seperation
plot(hierclus, cex = 0.1, pch = 21)
rect.hclust(hierclus, k = 5, border = seq(2, 8))

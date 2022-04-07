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
file_name <- "sample.csv"
# set current working directory, move into dataframe
setwd(current_dir)
df <- read.csv(file_name, header = T, sep = ";")
# understanding dataset
dim(df) # show dimension
names(df) # show all variable (column) names
head(df, 10) # show first 10 data
summary(df) # show short summary of all column
str(df) # show each variable types and values

### Data Wrangling ###
# if last column (MOTM) is NA, place the value 0, else it is 1
df[, ncol(df)] <- ifelse(complete.cases(df$MOTM), 1, 0)
# select all column that has only numbers but still in string format
# we want to change all ',' to '.', then convert to numeric type
target <- as.character(names(df %>% select(where(is.character) & 10:ncol(df))))
for (col in target) {
    col_index <- grep(paste("^", col, "$", sep = ""), colnames(df))
    df[, col_index] <- as.numeric(gsub(",", ".", df[, col_index]))
}
str(df) # check
# remove all other NA values if there is any, make sure rating is not 0
df <- df %>% filter(complete.cases(df)) %>% filter(Rating != "0")
dim(df)

### Exploratory Data Analysis ###
# does month affect rating or MOTM rate?
df %>%
    select(Date, Rating, MOTM) %>%
    mutate(month = substr(Date, 4, 5)) %>%
    group_by(month) %>%
    summarize(match_count = n(), avRating = mean(Rating), sum(MOTM))
# TODO!
# TODO - boxplot
# does day affect rating or MOTM rate?
pday1 <- ggplot(df, aes(Day)) + geom_bar()
pday2 <- ggplot(df, aes(x = Day, y = Rating)) + geom_point()
gridExtra::grid.arrange(pday1, pday2, nrow = 2)
df %>%
    select(Day, Rating, MOTM) %>%
    group_by(Day) %>%
    summarise(match_count = n(), avRating = mean(Rating), MOTM = sum(MOTM)) %>%
    mutate(MOTM_rate = MOTM / match_count)
# does venue affect rating or MOTM rate?
ggplot(df, aes(Venue)) + geom_bar()
df %>%
    select(Venue, Rating, MOTM) %>%
    group_by(Venue) %>%
    summarise(avRating = mean(Rating), MOTM = sum(MOTM), count = n()) %>%
    mutate(MOTM_rate = MOTM / count)
# TODO!
# plot relationships of various potential predictors
predictors <- colnames(df[, 10:(ncol(df) - 2)])
pp <- list()
for (i in seq(1, length(predictors))) {
    pp[[i]] <- ggplot(df, aes_string(x = predictors[i], y = "Rating")) +
        geom_point() + geom_smooth(method = "lm")
}
do.call(grid.arrange, pp)

corrplot(cor(df[,10:ncol(df)]), type="upper",
    method="color", addCoef.col = "black", number.cex = 0.6)

### Split Training & Testing Set ###
# drop unused predictors, remove data that has almost zero variance
df <- select(df, 10:ncol(df) & -c(nearZeroVar(df)))
# df_regr to predict rating, df_clas to predict MOTM
df_regr <- select(df, -MOTM)
df_clas <- select(df, -Rating) %>%
    mutate(MOTM = as.factor(MOTM))
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

### KNN Regression ###
set.seed(101)
# cross validation sampling with around 40-50 sample each group
cv_count <- floor(nrow(regr_train_data) / 45)
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
knnregr_model$bestTune # select best k
# predict test data, show rmse
regr_knn_predictions <- as.numeric(predict(knnregr_model, regr_test_data))
head(regr_knn_predictions)
RMSE(regr_knn_predictions, regr_test_data$Rating)
# plot of predicted values vs real values
plot(regr_test_data$Rating, regr_knn_predictions,
    main = "KNN Regression Prediction")
abline(0, 1, col = "darkblue")

### Linear Regression ###
# TODO

### Logistic Regression Classifier ###
set.seed(100)
# perform logistic regression using binomial family
logreg_model <- glm(MOTM ~ ., data = clas_train_data, family = "binomial")
summary(logreg_model)
# predict outcome based on test data, test with various cutoff level
cutoff <- 0.15
logreg_predictions <- ifelse(predict(logreg_model,
    newdata = clas_test_data, type = "response") > cutoff, 1, 0)
# display confusion matrix, overall accuracy
mean(logreg_predictions == clas_test_data$MOTM)
cm_logreg <- table(logreg_predictions, clas_test_data$MOTM)
cm_logreg
# display sensitivity and specificity
sensitivity(cm_logreg)
specificity(cm_logreg)
# display the coefficients to understand how significant each predictor is
exp(coef(logreg_model))

confusionMatrix(logreg_predictions %>% as.factor,
    clas_test_data$MOTM %>% as.factor, positive = "1")

### KNN Classification ###
knnclas_model <- train(
    MOTM ~ ., data = clas_train_data, method = "knn",
    trControl = trainControl("cv", number = 10),
    preProcess = c("center", "scale"),
    tuneLength = 15
)
knnclas_model %>% predict(clas_test_data) %>%
    confusionMatrix(clas_test_data$Rating)

nor <- function(x) {
    (x - min(x)) / (max(x) - min(x))
}
clas_train_data_norm <- as.data.frame(lapply(clas_train_data, nor))
clas_test_data_norm <- as.data.frame(lapply(clas_test_data, nor))
knnclas_pred <- knn(clas_train_data_norm, clas_test_data_norm,
    cl = clas_train_data_norm$MOTM, k = 13)
tab <- table(knnclas_pred, clas_test_data_norm$MOTM)
accuracy <- function(x) {
    sum(diag(x)) / (sum(rowSums(x))) * 100
}
accuracy(tab)

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
# plot to gain k = 5
plot(k_values, wcss_k, type = "b", pch = 19, frame = F,
    xlab = "Number of clusters K",
    ylab = "Total within-cluster sum of squares")
# perform kmeans clustering
kclus <- kmeans(df_clus_norm, centers = 5, nstart = 25)
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
rect.hclust(hierclus, k = 5, border = seq(2, 6))

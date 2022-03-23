"
SVC 2

Objective:
Classify whether a breast cancer is benign or malignant by SVC using
linear and radial kernel, along with cross validation tuning, using
cell thickness, cell size and cell shape as the predictors.
"

# Import required library and package
library(dplyr)
library(mlbench)
library(e1071)
data(BreastCancer, package="mlbench")

# Prepare data
bc <- BreastCancer[complete.cases(BreastCancer),]
head(bc)
dim(bc)
names(bc) # predictor: cell thickness, cell size, cell shape
bc[,2:4] <- sapply(bc[,2:4], as.numeric)
bc2 <- bc %>% # output: 1 for malignant, 0 otherwise
    mutate(y = factor(ifelse(Class == "malignant", 1, 0))) %>%
    select(Cl.thickness:Cell.shape, y)
head(bc2)
dim(bc2)

# Seperate training and test data
set.seed(100)
training.idx <- sample(1:nrow(bc2), size = nrow(bc2) * 0.8)
train.data <- bc2[training.idx,]
test.data <- bc2[-training.idx,]

# SVM classification (linear kernel)
m.svm <- svm(y ~ Cl.thickness + Cell.size + Cell.shape,
    data = train.data, kernel = "linear")
summary(m.svm)

# Predict using testing data
pred.svm <- predict(m.svm, test.data[,1:3])
table(pred.svm, test.data$y)
mean(pred.svm == test.data$y) # 0.9416

# Improve classification using other kernel functions and cross validation
set.seed(123) # ex: using radial kernel
m.svm.tune <- tune.svm(y ~ ., 
    data = train.data, kernel = "radial",
    cost = 10^(-1:2), gamma = c(.1, .5, 1, 2))
summary(m.svm.tune) # best parameters: gamma = 1, cost = 1
plot(m.svm.tune) # visualize parameter tuning

# Predict improved model using testing data
best.svm = m.svm.tune$best.model
pred.svm.tune = predict(best.svm, newdata=test.data[,1:3])
table(pred.svm.tune, test.data$y)
mean(pred.svm.tune == test.data$y) # 0.9635

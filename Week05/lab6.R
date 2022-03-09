# Lab 6
# TODO - Continue

# 1. Prepare, understanding, and visualize dataset
library(datarium)
library(ggplot2)
library(corrplot)
library(dplyr)

head(marketing)
dim(marketing)
summary(marketing)
ggplot(marketing, aes(x=youtube, y=sales)) + geom_point() + geom_smooth(method="lm")
ggplot(marketing, aes(x=facebook, y=sales)) + geom_point() + geom_smooth(method="lm")
ggplot(marketing, aes(x=newspaper, y=sales)) + geom_point() + geom_smooth(method="lm")

# 2. Split data into training and test sets
set.seed(100)
training.idx <- sample(1:nrow(marketing), nrow(marketing)*0.8)
train.data <- marketing[training.idx,]
test.data <- marketing[-training.idx,]

# 3. Perform KNN and LM models
modelKNN <- train(
    medv~., data = train.data, method = "knn",
    trControl = trainControl("cv", number = 10),
    preProcess = c("center","scale"),
    tuneLength = 10
)
modelLM <- lm(sales~., data = train.data)


# 4. Check residuals & improve LM if possible



# 5. Compare and interpret models 





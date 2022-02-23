# K-Nearest-Neighbors (KNN) Regresion

# 1. Prepare the data
library(caret)
data("Boston", package="MASS")

# 2. Check data summary
head(Boston)
dim(Boston)
summary(Boston)

# 3. Split data into test and training sets
set.seed(100)
training.idx <- sample(1:nrow(Boston), nrow(Boston)*0.8)
train.data <- Boston[training.idx,]
test.data <- Boston[-training.idx,]

# 4. Fit the model
model <- train(
    medv~., data = train.data, method = "knn",
    trControl = trainControl("cv", number = 10),
    preProcess = c("center","scale"),
    tuneLength = 10
)

# 5. Interpret the outputs
predictions <- predict(model, test.data)
head(predictions)
RMSE(predictions, test.data$medv)
plot(test.data$medv, predictions,main="Prediction performance of kNN regression"))
abline(0,1,col="red")

# K-Nearest-Neighbors (KNN) Regresion

"
Pros: simple, non-parametric without assumptions
Cons: no explicit model, not good for high-dim predictors
Issues: normalize data, test multiple k-values, assess model
"

# 1. Prepare the data
library(caret)
data("Boston", package="MASS")

# 2. Check data summary
head(Boston)
dim(Boston)
summary(Boston)
names(Boston)

# 3. Split data into test and training sets
set.seed(100)
training.idx <- sample(1:nrow(Boston), nrow(Boston)*0.8)
train.data <- Boston[training.idx,]
test.data <- Boston[-training.idx,]

# 4. Fit the model
set.seed(101)
model <- train(
    medv~., data = train.data, method = "knn",
    trControl = trainControl("cv", number = 10),
    preProcess = c("center","scale"),
    tuneLength = 10
)
plot(model)
model$bestTune # select the k that minimize RMSE
# preProcess: normalize the data
# trControl: use resampling methods (cross validation)
# tuneLength: number of possible k values to evaluate
# cv number: have around 40-50 each

# 5. Interpret the outputs
predictions <- predict(model, test.data)
head(predictions)
RMSE(predictions, test.data$medv)
plot(test.data$medv, predictions,main="Prediction performance of kNN regression")
abline(0,1,col="red")

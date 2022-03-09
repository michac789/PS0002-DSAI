# Linear Regression

"
Notes Here 
TODO - revise some parts
"

# 1. Prepare the data
library(corrplot)
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

# 4. Perform initial linear regression
lmodel <- lm(medv~., data = train.data)
summary(lmodel)
"
Interpretation:
Estimate: coef b0, b1, ..., bp
R-squared: how close data are to the fitted regression line
"

# 5. Make predictions based on test data
predictions <-predict(lmodel, test.data)
plot(test.data$medv, predictions, main="Prediction performance of linear regression")
abline(0,1, col="red")
RMSE(predictions, test.data$medv) # 6.28

# 6. Check residuals
par(mfrow=c(2,2))
plot(lmodel)
"
If the residuals are not randomly distributed, has an outliers or trend, then the model
has room for more improvement.
"
# Visualize correlation between outcome medv and each predictor
corrplot(cor(train.data), type="upper", method="color", 
    addCoef.col = "black", number.cex = 0.6)

# 7. Remove outliers from training data, resample the data
# (Based on the residual plot before)
Boston1 <- Boston[-c(369, 373, 413),]
set.seed(100)
training.idx <- sample(1:nrow(Boston1), size=nrow(Boston1)*0.8)
train.data <- Boston1[training.idx,]
test.data <- Boston1[-training.idx,]

# 8. Perform linear regression with second order term
# choose predictors with |r|>0.5 to enter model as second order term (based on residual)
p2model<- lm(medv~crim+zn+indus+chas+nox+rm+age+dis+rad+tax+ptratio+black+lstat+
    I(rm^2)+I(ptratio^2)+I(lstat^2), data=train.data)
summary(p2model)

# 9. Make revised prediction based on the new model
predictions <- predict(p2model, test.data)
RMSE(predictions, test.data$medv) # 3.68
plot(p2model)

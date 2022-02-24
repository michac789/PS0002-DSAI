# Linear Regression

# 1. Prepare the data & check summary
library(corrplot)
library(caret)
data("Boston", package="MASS")
summary(Boston)

# 2. Perform initial linear regression
lmodel <- lm(medv~., data = train.data)
summary(lmodel)



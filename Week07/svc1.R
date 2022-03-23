"
SVC 1

Objective:
Introducing SVC with linear kernel using Iris Dataset 
"

# Obtain the data
df <- iris
head(df)
dim(df)

# Create SVC model with linear kernel
# Predicting whether a particular flower is setosa species or not
# Predictor used: petal width and petal length
library(e1071) # install this library for svm function
setosa <- as.factor(iris$Species == "setosa")
df2 <- scale(df[,-5])
head(df2)
model_svm <- svm(setosa~Petal.Width+Petal.Length,
    data=df2, kernel="linear")
model_svm

# Analyze the results
pred <- fitted(model_svm) # all predicted results
freq <- table(pred, iris$Species)
plot(Petal.Length~Petal.Width, data=df2, col=setosa)
cf <- coef(model_svm)
abline(-cf[1]/cf[3], -cf[2]/cf[3], col="red")
abline(-(cf[1] + 1)/cf[3], -cf[2]/cf[3], col="blue")
abline(-(cf[1] - 1)/cf[3], -cf[2]/cf[3], col="blue")
points(model_svm$SV, pch = 5, cex = 2)

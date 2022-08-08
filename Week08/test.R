"
Name: Michael Andrew Chan
Matric N0: U2140550D
PS0002 Quiz (09/03/2022)

### Part 1 ###
(1) a
(2) c
(3) a
(4) d
(5) b

### Part 2 ###
written below using R code
"

# load data & required packages
library(dplyr)
library(ggplot2)
library(corrplot)
library(caret)
data("Auto", package="ISLR")

# understanding the 'Auto' dataset
head(Auto, 10)
summary(Auto)
names(Auto)
dim(Auto)

# predict mpg with cylinders > 3 using other variables except
# cylinders, horsepower, weight, acceleration

# prepare the required data
df <- Auto %>%
    filter(cylinders > 3) %>%
    select(-cylinders, -year, -origin, -name)
head(df)
names(df)
dim(df)

# (i)

# visualize relationship between predictors and outcome
ggplot(df, aes(x=displacement, y=mpg)) + geom_point() + geom_smooth(method="lm")
ggplot(df, aes(x=horsepower, y=mpg)) + geom_point() + geom_smooth(method="lm")
ggplot(df, aes(x=weight, y=mpg)) + geom_point() + geom_smooth(method="lm")
ggplot(df, aes(x=acceleration, y=mpg)) + geom_point() + geom_smooth(method="lm")

# split data into test and training sets
set.seed(100)
training.idx <- sample(1:nrow(df), nrow(df)*0.8)
train.data <- df[training.idx,]
test.data <- df[-training.idx,]
dim(train.data) # 310
dim(test.data) # 78

# fit using KNN model
set.seed(101)
model <- train(
    mpg~., data = train.data, method = "knn",
    trControl = trainControl("cv", number = 7), # 310/50 = approx 7
    preProcess = c("center","scale"),
    tuneLength = 10
)
model
plot(model)
model$bestTune # k = 15

# interpret knn results
predictions <- predict(model, test.data)
head(predictions)
RMSE(predictions, test.data$mpg) # 4.004874
plot(test.data$mpg, predictions, main="Prediction KNB Regression")
abline(0,1,col="red")

# fit using linear regression model
lmodel <- lm(mpg~., data = train.data)
summary(lmodel)

# interpret linreg results
predictions <-predict(lmodel, test.data)
plot(test.data$mpg, predictions, main="Prediction Linear Regression")
abline(0,1, col="red")
RMSE(predictions, test.data$mpg) # 4.274151

# check residue
par(mfrow=c(2,2))
plot(lmodel)

# visualize correlation between outcome mpg and each predictor
corrplot(cor(train.data), type="upper", method="color", 
    addCoef.col = "black", number.cex = 0.6)

"
Answers to 2 (ii)

a. 
k = 15
RMSE = 4.004874

b.
significanct predictors 0.05?
None of the variables has this correlation

c.
R-squared measures how correlated two variables are, higher and positive R-squared
(closer to 1 or -1) means that there is a high correlation.
It seems there is positive (gradient) or increasing correlation of mpg with acceleration,
negative correlation with displacment, horsepower and weight.
Weight has the strongest negative correlation.

d.
I would prefer knn because it has smaller RMSE,
and the linear correlation based on the corrplot is not that high.
Though, it is still possible to improve the linear model (refer to (e))

e.
Yes, it still can be improve because the residual graph
has some outliers and there are still patterns observed.
(it is not totally random)
Potential improvements:
- consider removing some outliers
- consider adding second degree term

"
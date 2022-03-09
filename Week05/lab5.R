# Lab 5 - KNN Regression VS Linear Regression


##### KNN Regression #####

# 0. Load required packages
library(nycflights13)
library(dplyr)
library(ggplot2)
library(caret)

# 1. Prepare required data set
head(flights)
dim(flights)
names(flights)
df <- flights %>%
    mutate(gain_of_delay = arr_delay - dep_delay) %>% 
    filter(air_time > 550, carrier == "UA") %>%
    select(air_time, gain_of_delay)

# 2. Inspect summary, create plot to visualize relationship
summary(df)
head(df)
dim(df)
plot(df, main="Air Time VS Gain of Delay")
ggplot(df, aes(x=air_time, y=gain_of_delay)) + geom_point() + geom_smooth()

# 3. Split data into training and test sets
set.seed(100)
training.idx <- sample(1:nrow(df), nrow(df)*0.8)
train.data <- df[training.idx,]
test.data <- df[-training.idx,]
dim(train.data) # 287

# 4. Perform KNN regression
set.seed(101)
model <- train(
    gain_of_delay~., data = train.data, method = "knn",
    trControl = trainControl("cv", number = 6), # 287/50 = approx 6
    preProcess = c("center","scale"),
    tuneLength = 10
)
plot(model)
model$bestTune # k = 13

# 5. Interpret and assess its prediction performance
predictions <- predict(model, test.data)
head(predictions)
RMSE(predictions, test.data$gain_of_delay) # RMSE = 10.86
plot(test.data$gain_of_delay, predictions,main="KNN Regression")
abline(0,1,col="red")


##### Linear Regression #####

# 0 - 3: same as previous

# 4. Perform linear regression
lmodel <- lm(gain_of_delay~., data = train.data)
summary(lmodel)

# 5. Make predictions
predictions <-predict(lmodel, test.data)
plot(test.data$medv, predictions, main="Prediction performance of linear regression")
abline(0,1, col="red")
RMSE(predictions, test.data$gain_of_delay)

# 6. Check residuals
plot(lmodel)

# 7. Remove outliers from training data
train.data1<-train.data[-c(65,178,195),]
lmodel.1<- lm(gain_of_delay~air_time, data = train.data1)
summary(lmodel.1)

# 8. Perform another linear regression, get better model
predictions.1 <-predict(lmodel.1, test.data)
RMSE(predictions.1, test.data$gain_of_delay)
plot(test.data$gain_of_delay, predictions.1, main="Prediction performance of linear regression")
abline(0,1, col="red")
plot(lmodel.1)

# Note on potential improvements: add second-order predictor
# this will be done on the next example

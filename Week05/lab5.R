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

# 2. Inspect the summary of the prepared data set
summary(df)
head(df)
dim(df)

# 3. Create plot to visualize relationship
plot(df, main="Air Time VS Gain of Delay")
ggplot(df, aes(x=air_time, y=gain_of_delay)) + geom_point() + geom_smooth()

# 4. Split data into training and test sets
set.seed(100)
training.idx <- sample(1:nrow(df), nrow(df)*0.8)
train.data <- df[training.idx,]
test.data <- df[-training.idx,]
dim(train.data) # 287

# 5. Perform KNN regression
set.seed(101)
model <- train(
    gain_of_delay~., data = train.data, method = "knn",
    trControl = trainControl("cv", number = 6), # 287/50 = approx 6
    preProcess = c("center","scale"),
    tuneLength = 10
)
plot(model)
model$bestTune # k = 13

# 6. Interpret and assess its prediction performance
predictions <- predict(model, test.data)
head(predictions)
RMSE(predictions, test.data$gain_of_delay) # RMSE = 10.86
plot(test.data$gain_of_delay, predictions,main="KNN Regression")
abline(0,1,col="red")


##### Linear Regression #####

# TODO










dfo <- read.csv(file_name, header = T, sep = ";")
dfo <- select(dfo, Gls:MOTM)
dfo <- dfo[complete.cases(dfo), ]
dfo <- dfo %>% select(Carries, Rating)
set.seed(100)
training.idx <- sample(1:nrow(dfo), nrow(dfo)*0.8)
train.data <- dfo[training.idx,]
test.data <- dfo[-training.idx,]

# 4. Fit the model
set.seed(101)
model <- train(
    Rating~., data = train.data, method = "knn",
    trControl = trainControl("cv", number = 10),
    preProcess = c("center","scale"),
    tuneLength = 10
)
plot(model)
model$bestTune

predictions <- predict(model, test.data)
head(predictions)
RMSE(predictions, test.data$Rating)


# editstr <- function(row) {
#     str <- row[37]
#     if (substr(str, 1, 1) == ",") {
#         return(as.numeric(paste(str[1], ".", str[3])))
#     } else {
#         return(as.numeric(str))
#     }
# }
# df[, 37] <- apply(df, 1, editstr)
# make sure rating is numeric
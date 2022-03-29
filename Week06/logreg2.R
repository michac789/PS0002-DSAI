"
Logistic Regression 2

Objective:
Classify whether a breast cancer is benign or malignant using logistic
regression, then interpret the results.
"

# Prepare data
library(dplyr)
data(BreastCancer, package="mlbench")
str(BreastCancer)
dim(BreastCancer)
head(BreastCancer)
bc <- BreastCancer[complete.cases(BreastCancer),] # remove missing values
bc[,2:4]<- sapply(bc[,2:4], as.numeric) # use cell thickness, size, shape
bc <- bc %>% mutate(y=factor(ifelse(Class=="malignant", 1,0))) %>%
    select(Cl.thickness:Cell.shape, y) # 1: malignant, 0: benign
str(bc)
dim(bc)

# Split into training and testing sets
set.seed(100)
training.idx <- sample(1:nrow(bc), size=nrow(bc)*0.8)
train.data <- bc[training.idx,]
test.data <- bc[-training.idx,]

# Perform logistic regression
mlogreg <- glm(y~Cl.thickness+Cell.size+Cell.shape, data=train.data,
    family="binomial")
summary(mlogreg)

# Interpret the results
pred.p <- predict(mlogreg, newdata=test.data, type="response")
y_pred <- ifelse(pred.p > 0.5, 1, 0)
mean(y_pred == test.data$y)
table(y_pred, test.data$y)

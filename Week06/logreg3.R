"
Logistic Regression 3

Objective:
From the dataset gradadmit.csv that contains 4 variables:
gre (graduate record exam scores), gpa, rank, predict whether that student
is admitted (admit=1) or not (admit=0), with the use of logistic regression
"
# setwd("C:/My Files/MY REPOSITORIES/PS0002/Week06")

# 1. Get familiar with the data set
df <- read.csv("assets/gradadmit.csv", header = T)
str(df)
dim(df)
names(df)
head(df)
table(complete.cases(df))
df$admit <- factor(df$admit)
df$rank <- factor(df$rank)
plot(as.numeric(df$gre), df$admit)
plot(as.numeric(df$gpa), df$admit)
plot(as.numeric(df$rank), df$admit)

# 2. Split data into training set and testing set
set.seed(100)
training.idx <- sample(1:nrow(df), size=nrow(df)*0.8)
train.data <- df[training.idx,]
test.data <- df[-training.idx,]

# 3. Perform logistic regression
mlogreg <- glm(admit~., data=train.data,
    family="binomial")
summary(mlogreg)
exp(coef(mlogreg))

# 4. Predict test data
pred <- predict(mlogreg, newdata=test.data, type="response")
y_pred <- ifelse(pred > 0.5, 1, 0)
mean(y_pred == test.data$admit)
table(y_pred, test.data$admit)

# 5. Analysis
"
Confusion Matrix:
48  19
7   6

Interpretation of linear regression model:
Based on the training data, the fitted logistic regression shows that GPA
and rank are much more significant then gre, which is not significant.

Interpretation of exp(coef(mlogreg)):
It shows that 1 unit changes in gpa doubles the odd of being admitted, but
changes in gre is not that significant. Odds of applicants being admitted
from rank2, rank3 and rank4 are about 41%, 23% and 17% respectively compared
to those from rank1.
*rank1 is used as a baseline level for the other ranks (why we need factor)

Interpretation of confusion matrix:
True Positive: 48, True Negative: 6
False Positive: 19, False Negative: 7
Accuracy: (48+6)/(48+6+19+7) = 67.5% (overall)
"

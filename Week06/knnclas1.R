"
KNN Classification 1

Objective:
Introducing KNN for classification using iris data
"

# Prepare the data
df <- data(iris)
head(iris)
dim(iris)

# Normalizing function (since different scales might be used)
nor <- function(x) {
    (x - min(x)) / (max(x) - min(x))
}

# Divide into training and testing set, normalize
set.seed(100)
ran <- sample(1:nrow(iris), nrow(iris)*0.9)
iris_norm <- as.data.frame(lapply(iris[,c(1,2,3,4)], nor))
summary(iris_norm)
iris_train <- iris_norm[ran,]
nrow(iris_train)
iris_test <- iris_norm[-ran,]
nrow(iris_test)
iris_target_category <- iris[ran, 5]
iris_test_category <- iris[-ran, 5]

# Perform KNN classifier
library(class)
pr <- knn(iris_train, iris_test, cl=iris_target_category, k=13)
tab <- table(pr, iris_test_category)
tab

# Assess accuracy
accuracy <- function(x){
    sum(diag(x))/(sum(rowSums(x))*100)
}
accuracy(tab)

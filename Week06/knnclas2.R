"
KNN Classification 2

Idea:
- measure the distance from a new input x to every point in the training set
- identify and take k data that has the smallest distance
- the most represented class by these k neareast neighbours is considered the output

Steps:
1) Preparing anx exploring the data
understanding data structure, selecting features of interest,
data normalization, splitting training and data sets
2) Training a model on data
3) Evaluate the model performance
4) Improve the performance of the model

Pros:
- Non-parametric approach; no distribution assumptions on data
- Simple algorithm to interpret & understand

Cons:
- Computationally expensive (stores all training data)
- Sensitive to irrelevant features and the scale of the data
"

# Import required packages
library(mlbench)
library(dplyr)
library(class)

print("e")

# Prepare and explore data
data(BreastCancer, package="mlbench")
bc <- BreastCancer[complete.cases(BreastCancer),]
bc[,2:4]<- sapply(bc[,2:4], as.numeric)

bc <-BreastCancer[complete.cases(BreastCancer),]
bc[,2:4] <- sapply(bc[,2:4], as.numeric)
bc <- bc %>%
    mutate(y=factor(ifelse(Class=="malignant", 1,0))) %>%
    select(Cl.thickness:Cell.shape, y)

# Normalize numeric variables
nor <-function(x) { (x -min(x))/(max(x)-min(x)) }
bc[,1:3] <- sapply(bc[,1:3], nor)
#split data
set.seed(100)
training.idx <- sample(1: nrow(bc), size=nrow(bc)*0.8)
train.data <-bc[training.idx, ]
test.data <- bc[-training.idx, ]
#kNN classification
library(class)
set.seed(101)
knn1<-knn(train.data[,1:3], test.data[,1:3], cl=train.data$y, k=2)
mean(knn1 == test.data$y)
# 0.9635036
table(knn1, test.data$y)


# Training a model on data


# Evaluate the model performance


# Improve the performance of model





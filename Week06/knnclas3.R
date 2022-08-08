"
KNN Classification 3

Objective:
A data scientist in a bank was given a bank credit dataset and asked by
his/her manager: should the bank give a loan to an individual? Is that
person closer in characteristics to people who defaulted or did not
default on their loans?
"
# setwd("C:/My Files/MY REPOSITORIES/PS0002/Week06")

# Load data
library(dplyr)
library(class)
df <- read.csv("assets/gradadmit.csv", header = T, sep = ",")
head(df)
dim(df)

# Normalize numeric variables
nor <- function(x){
    (x - min(x))/(max(x) - min(x))
}
df[,2:4] <- sapply(df[,2:4], nor)
df$admit <- factor(df$admit)
str(df)

# Split into training and test sets
set.seed(100)
training.idx <- sample(1:nrow(df), nrow(df)*0.8)
train.data <- df[training.idx,]
test.data <- df[-training.idx,]

# Perform KNN classification



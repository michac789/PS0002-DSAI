# Lab 1 - Task 2

# Import packages & set working directory
# setwd("C:/My Files/MY REPOSITORIES/PS0002/Week02")

# Define matrix X and Y based on specification
X = matrix(c(rep(1, 4), seq(1, 8, 2)), nrow = 4, ncol = 2, byrow = F)
Y = matrix(c(4, 6, 13, 20), nrow = 4, ncol = 1)

# Define B = (X^T X)^(-1) X^T Y
# Hint: %*% for matrix multiplication, t() for transpose, solve() for inverse
B = solve(t(X) %*% X) %*% t(X) %*% Y

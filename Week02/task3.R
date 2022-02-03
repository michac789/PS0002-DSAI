# Lab 1 - Task 3

# Import packages & set working directory
# setwd("C:/My Files/MY REPOSITORIES/PS0002/Week02")
sample_test <- c(3, 6, 7, 9, 14)

# Write a function that calculate first four center moments given a data set
moments <- function(data){
    m <- numeric(4)
    m[1] <- mean(data)
    for(i in 2:4){
        m[i] <- mean((data - m[1]) ^ i)
    }
    return(m)
}

# Testing using sample_test data
four_central_moments = moments(sample_test)
four_central_moments

# Obtain first four central moments for height in data frame 'lab1'
# Ans:  165.86667    75.98222   205.46193 13883.27461
moments_height = moments(lab1$height)
moments_height

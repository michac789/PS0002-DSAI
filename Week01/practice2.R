# Lab 1 (Part 2)
# Get familiar using R and RStudio

##################################################
# Task 2

# Define matrix X and Y based on specification
x <- matrix(c(rep(1, 4), seq(1, 8, 2)), nrow = 4, ncol = 2, byrow = F)
y <- matrix(c(4, 6, 13, 20), nrow = 4, ncol = 1)

# Define B = (X^T X)^(-1) X^T Y
# Hint: %*% for matrix multiplication, t() for transpose, solve() for inverse
b <- solve(t(X) %*% X) %*% t(X) %*% Y


##################################################
# Task 3
sample_test <- c(3, 6, 7, 9, 14)

# Write a function that calculate first four center moments given a data set
moments <- function(data) {
    m <- numeric(4)
    m[1] <- mean(data)
    for (i in 2:4) {
        m[i] <- mean((data - m[1]) ^ i)
    }
    return(m)
}

# Testing using sample_test data
four_central_moments <- moments(sample_test)
four_central_moments

# Obtain first four central moments for height in data frame 'lab1'
# Ans:  165.86667    75.98222   205.46193 13883.27461
moments_height <- moments(lab1$height)
moments_height


##################################################
# Task 4

# Write a program to find the root within [-4, 0] from the function:
# f(x) = -2x^2 - 5x + 7, using bisection algorithm

# Pseudocode:
# 1.Start with [xmin,xmax]
# 2.Find xmid
# 3.If (f(xmin)*f(xmid)<0) use [xmin,xmid]
# Else use [xmid,xmax]
# In either case, call this new smaller interval [xmin,xmax]
# 4.Go to 2, unless f(xmid)≈0 or interval length≈0

# Returns the midvalue given 2 numbers
get_midval <- function(x1, x2) {
    return((x1 + x2) / 2)
}

# Returns the value of f(x) given the x
func_x <- function(x_val) {
    value <- (-2) * (x_val) ^ 2 - 5 * x_val + 7
    return(value)
}

# Returns the approximate root
find_root <- function(xmin, xmax) {
    while (TRUE) {
        xmid <- get_midval(xmin, xmax)
        if (abs(func_x(xmid)) < 1e-6 || abs(xmax - xmin) < 1e-6) {
            return(xmid)
        } else {
            if (func_x(xmin) * func_x(xmid) < 0) {
                xmax <- xmid
            } else {
                xmin <- xmid
            }
        }
    }
}

# Call the function
find_root(-4, 0)
find_root(-3, 10)

# Lab 1 - Task 3

# Import packages & set working directory
# setwd("C:/My Files/MY REPOSITORIES/PS0002/Week02")

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
get_midval <- function(x1, x2){
    return((x1 + x2) / 2)
}

# Returns the value of f(x) given the x
func_x <- function(x_val){
    value <- (-2) * (x_val) ^ 2 - 5 * x_val + 7
    return(value)
}

# Returns the approximate root
find_root <- function(xmin, xmax){
    while(TRUE){
        xmid = get_midval(xmin, xmax)
        if(abs(func_x(xmid)) < 1e-6 || abs(xmax - xmin) < 1e-6){
            return(xmid)
        } else {
            if(func_x(xmin) * func_x(xmid) < 0){
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

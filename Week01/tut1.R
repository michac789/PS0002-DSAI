# Tutorial 1

# Get familiar using R and RStudio
# Use getwd() to get your working directory
# Use setwd() to change your working directory
# Data structures: vectors, matrix, data frame, list (commonly used)

# Vector
vec <- c(10, numeric(4), rep(2, 3), rep(1:2, 2), 
    rep(c(5, 7), 2:3), seq(6, 10, 2))
print(vec)
# numeric(n): vector of all 0 with length n
# rep(a, b): vector with element a for b times
# seq(start, end, step): similar to range() in python

# Matrix
v = c(1:6) * 2
dim(v) = c(2, 3)
print(v)

# Data Frame
df1 = data.frame(v)
row.names(df1) = c('Row1', 'Row2')
print(df1)

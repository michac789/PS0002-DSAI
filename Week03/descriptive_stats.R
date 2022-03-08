"
Data Visualization:
Represents the data in some forms, help to...
data cleaning, feature selection, sampling process, communicate with audience

Types of variables:
Categorical/qualitative -> nominal / ordinal
Numerical/quantitative -> discrete / continuous
Location: center of data (mean, median)
Spread: variability of data (var, sd, range, iqr, coef of var)
Other measures: min, max, quartile, percentile, skewness, kurtosis
"
# Descriptive Statistics

# Set working directory
# setwd("C:/My Files/MY REPOSITORIES/PS0002/Week03")
ex1 <- read.table("assets/ex1ar.txt", header = T)

# Define some statistical function
cv <- function(x){ # coefficient of variation
    return (sd(x) / mean(x) * 100)
}
skew <- function(x){ # skewness
    n <- length(x)
    m2 <- sum((x-mean(x))^2)/n
    m3 <- sum((x-mean(x))^3)/n
    return (m3/m2^(3/2))*(sqrt(n*(n-1))/(n-2))
}
kurtosis <- function(x){ # kurtosis
    n <- length(x)
    m2 <- sum((x-mean(x))^2)/n
    m4 <- sum((x-mean(x))^4)/n
    return ((n-1)/((n-2)*(n-3)))*((((n+1)*m4)/(m2^2))-3*(n-1))
}

# Get statistics
ex1ar <- ex1[,1]
summary(ex1ar)
mean(ex1ar)
median(ex1ar)
min(ex1ar)
max(ex1ar)
range(ex1ar)
quantile(ex1ar)
var(ex1ar)
sd(ex1ar)
IQR(ex1ar)
cv(ex1ar)
skew(ex1ar)
kurtosis(ex1ar)

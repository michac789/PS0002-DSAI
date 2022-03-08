# Visualisation Techniques

# Set working directory
# setwd("C:/My Files/MY REPOSITORIES/PS0002/Week03")
ex1 <- read.table("assets/ex1ar.txt", header = T)
ex1ar <- ex1[,1]

# Histogram 1 - simple histogram & normal curve
hist(ex1ar, include.lowest=TRUE, freq=TRUE, main=paste("Histogram of 
return"), xlab="return", ylab="frequency", axes=TRUE)
Xpt <- seq(-10, 100, 0.1) 
Ypt <- dnorm(seq(-10, 100, 0.1), mean(ex1ar), sd(ex1ar))
Ypt <- Ypt * length(ex1ar) * 10
lines(Xpt, Ypt)

# Histogram 2 - bins in continuous distribution
library(AmesHousing)
library(ggplot2)
ames <- AmesHousing::make_ames()
ggplot(ames, aes(Sale_Price)) + geom_histogram()
hist(ames$Sale_Price, breaks=30, main="Histogram of sale price", col="green")

# Histogram 3 - scaling & identifying outliers
ggplot(ames, aes(Sale_Price)) + 
    geom_histogram(bins = 100) + 
    geom_vline(xintercept = c(150000, 170000), color = "red", lty = "dashed") + 
    scale_x_log10( labels = scales::dollar, 
    breaks = c(50000, 125000, 300000) 
)




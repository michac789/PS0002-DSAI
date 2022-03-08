# Visualisation Techniques

# Set working directory & import required packages
# setwd("C:/My Files/MY REPOSITORIES/PS0002/Week03")
library(AmesHousing)
library(ggplot2)
library(gridExtra)
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

# QQPlot (quantile-quantile plot): comparing sample with known distribution
qqnorm(ex1ar)
qqline(ex1ar)
qqnorm(ames$Sale_Price, main = "Untransformed Normal Q-Q Plot") 
qqline(ames$Sale_Price) 
qqnorm(log(ames$Sale_Price), main = "Log Transformed Normal Q-Q Plot") 
qqline(log(ames$Sale_Price)) 

# Stem and Leaf Plot
stem(ex1ar)

# Boxplot: Q3+1/5*IQR, Q3, Median, Q1, Q1-1.5*IQR
boxplot(ex1ar)
p1 <- ggplot(ames, aes("var", Sale_Price)) + 
    geom_boxplot(outlier.alpha = .25) + 
    scale_y_log10( 
    labels = scales::dollar, 
    breaks = quantile(ames$Sale_Price) 
) 
p1

# Violin plot
p2 <- ggplot(ames, aes("var", Sale_Price)) + 
    geom_point() + 
    geom_violin() + 
    scale_y_log10( 
    labels = scales::dollar, 
    breaks = quantile(ames$Sale_Price) 
) 
gridExtra::grid.arrange(p1, p2, ncol = 2) # display two graph

# Density Curves
d1 <- ggplot(ames, aes(Sale_Price)) + 
    geom_density() 
d2 <- ggplot(ames, aes(Sale_Price)) + 
    geom_density() + 
    geom_rug()
gridExtra::grid.arrange(d1, d2, nrow = 1) 

# Bar Chart
ggplot(ames, aes(MS_Zoning)) + geom_bar()

# Scatter Plot
ggplot(ames, aes(x = Gr_Liv_Area, y = Sale_Price)) + geom_point(alpha = .3) 
p1 <- ggplot(ames, aes(x = Gr_Liv_Area, y = Sale_Price)) +
    geom_point(alpha = .3) +
    geom_smooth(method = "lm", se = FALSE, color = "red", lty = "dashed") +
    geom_smooth(se = FALSE, lty = "dashed") +
    ggtitle("Non-transformed variables")
p2 <- ggplot(ames, aes(x = Gr_Liv_Area, y = Sale_Price)) +
    geom_point(alpha = .3) +
    geom_smooth(method = "lm", se = FALSE, color = "red", lty = "dashed") +
    geom_smooth(se = FALSE, lty = "dashed") +
    scale_x_continuous(trans = scales::log_trans()) +
    scale_y_continuous(trans = scales::log_trans()) +
    ggtitle("ln-transformed variables")
gridExtra::grid.arrange(p1, p2, nrow = 1)

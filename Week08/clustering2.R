"
Unsupervised Learning - Clustering 2

Objective:
???
"

# Load data
setwd("C:/My Files/MY REPOSITORIES/PS0002/Week08")
df <- read.csv("assets/computer.csv", header = T, sep = ",")
head(df)
names(df)
dim(df)

# Prepare data of interest & standardize data
df2 <- df[complete.cases(df),]
df2 <- scale(df2[,c(1:5, 9:10)])
head(df2)
dim(df2)

# Perform kmeans clustering with initial K value
km <- kmeans(df2, centers=2, nstart=25)
str(km)

# Determine optimal K using elbow method
wcss <- function(k){
    kmeans(km, k, nstart=10)$tot.withinss
}
k.values <- 1:15
set.seed(100)
wcss_k <- sapply(k.values, wcss)
plot(k.values, wcss_k, type="b", pch=19, frame=F,
    xlab="Number of clusters K",
    ylab="Total within-cluster sum of squares")

# Perform hierarchical clustering



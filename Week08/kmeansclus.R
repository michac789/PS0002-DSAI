"
K-Means Clustring 1

Objective:
Introducing K-means clustering to cluster flower species from iris dataset.
"

# Load data
head(iris)
dim(iris)

# Implement k-means clustering, show confusion matrix
kc <- kmeans(iris[,-5], centers=3, nstart=3)
table(iris$Species, kc$cluster)

# Visualize the result
plot(iris[,1:2], col=kc$cluster)
points(kc$centers[,1:2], col=1:3, pch=8, cex=2)

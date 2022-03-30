"
K-Means Clustring 2

Objective:
Perform K-means classification based on USArrests data, with the selection of an
optimal K and apply hierarchical clustering.
"

# Load data
data(USArrests)
str(USArrests)
dim(USArrests)
head(USArrests)

# Normalize data
arr <- scale(USArrests)
head(arr)

# Perform kmeans classification
k2 <- kmeans(arr, centers=2, nstart=25)
str(k2)
k2
"
centers: no of clusters, nstart: configurations attempted, iter.max: def 10

From the output:
cluster = a vector of integers 1,2 indicating the cluster allocated
centers = a matrix of cluster centers
totss = sum of squares
tot.withinss = total within-cluster sum of squares
betweenss = the between-cluster sum of squares
size = number of points in each cluster
"

# Find optimal number of clusters K (use elbow method)
wcss <- function(k){
    kmeans(arr, k, nstart=10)$tot.withinss
}
k.values <- 1:15
set.seed(100)
wcss_k <- sapply(k.values, wcss)
plot(k.values, wcss_k, type="b", pch=19, frame=F,
    xlab="Number of clusters K",
    ylab="Total within-cluster sum of squares")

# Final clustering (use k=4 from previous step)
set.seed(100)
k4.final <- kmeans(arr, 4, nstart=25)
k4.final

# Extract clusters and find descriptive statistics
library(dplyr)
USArrests %>% mutate(Cluster=k4.final$cluster) %>%
    group_by(Cluster) %>% summarise_all("mean")

# Hierarchical clustering
d <- dist(arr, method="euclidean") # dissimilarity matrix
hc1 <- hclust(d, method="complete")
plot(hc1, cex=0.6, hang=-1) # plot dendrogram
rect.hclust(hc1, k=4, border=2:5) # draw border around 4 clusters

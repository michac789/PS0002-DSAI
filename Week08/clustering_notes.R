"
Unsupervised Learning - Clustering (Theory)

--- Clustering ---
Usage: group similar objects together
Typical applications of clustering:
- pre-processing step for supervised learning
- data inspection / experimental data analysis
- discreting real-valued variables in non-uniform buckets
- data compression

--- K-Means Clustering Concept ---
Goal: partition data into K disjoint subsets
Inputs:
> p-dimensional real vectors (x1, ..., xn)
> K, the desired number of clusters
Output:
> mapping of vectors into K clusters (disjoint subsets)
C: {1, ..., n} -> {1, ..., K}
Algorithm:
- Initialise C randomly
- Repeat until C stops changing:
compute the centroid of each cluster (mean of all instances in the cluster),
reassign each instance to the cluster with the closest centroid

--- K-Means Clustering Questions ---
> Will k-means terminate?
Yes, after a few iterations when the difference of the squared euclidean distance
is already negligible, the algorithm will terminate.
> Does the result always the same?
No, because it uses coordinate descent, where the parameters are the cluster center
coordinates. It minimises the sum of squared euclidean distances but only found an
optimal local minima, but not globally optimal. Additionally, the result is also
affected by the initial assignment of clusters.
> How to choose the initial cluster centers?
There are some advanced methods which won't be discusses for this introductory course.
> How to determine the number of clusters?
This is also a tricky question. Generally, we can delete cluster that cover too few
points, split cluster that covers too many points or add clusters for outliers, use
hierarchical method first or use minimum description length.

--- Hierarchichal Clustering ---
Example: Agglomerative Clustering
Input: pairwise distances d(x, x') between a set of data objects {xi}.
Output: a hierarchical clustering
Algorithm:
1) Assign each instance as its own cluster on a working list W
2) Repeat:
- Find two clusters in W that are most similar, remove them from W
- Add their union to W, until W contains a single cluster with all the data objects
"

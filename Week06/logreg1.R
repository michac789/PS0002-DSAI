"
Logistic Regression 1

Objective:
Introducing logistic regression for classification purpose
"

# Load the data
data(BreastCancer, package="mlbench")
bc <- BreastCancer[complete.cases(BreastCancer),]
str(bc)
dim(bc)
head(bc)

# Visualize using scatterplot
x <- as.numeric(bc$Cell.size)
y <- ifelse(bc$Class=="malignant", 1, 0)
plot(x, y, xlab="Cell.size", ylab="Class", pch=19)

# Perform logistic regression
y <- factor(y, levels=c(0, 1))
table(y)
glm(y ~ x, family="binomial")

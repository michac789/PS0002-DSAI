"
Regression Notes (Theory)

--- Statistical Modeling ---
Definition: predict one variable using a set of other variables
Suppose we are observing p+1 number of variables and we are making n sets observations.
yi denotes the outcome or respone variable, from an observation i
xij denotes the predictor variables, from observation i and the jth predictor
i = 1, 2, .., n; j = 1, 2, ..., p
Y=f(X)+e, e: error; f is the unknown function relating Y to X
yi^ = f^(xi1, ..., xip)

--- Regression VS Classification ---
Regression problems: quantitative response
Classification: categorical response
Create a model (suitable estimate f^) and minimize the loss function e.
Common loss function is the Mean Squared Error:
MSE = 1/n sigma(i to n)(yi - y^i)^2

--- K-Nearest Neighbours ---
Predict based on the k nearest observations
yi^ = 1/k sigma(i to k)(yni)
*choice of k matters (small k: more error, large k: overfitting)
When multiple predictors are used, Euclidean distance is used:
d(xi-xj)=sqrt(sigma(n to p)(xin-xjn)^2)

--- Linear Regression ---
Y=f(X)+e = b0+b1x+e (for one predictor variable)
Minimize the lost function MSE, take partial derivative,
get global minimum and find explicit formula or b0, b1
b1^=sigmai(xi-x~)(yi-y~)/sigmai(xi-x~), b0^=y~-b1^x~

--- Evaluating Model ---
Linear regression (parametric model): parameters gained has fixed form
KNN (non-parametric model): depends on the whole training set
Things to consider:
- Which model gives less predictive error (loss function)?
- Which model takes less space, less time to perform inference or predict?
"

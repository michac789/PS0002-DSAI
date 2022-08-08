"
Classification Notes (Theory)

--- Why Not Regular Regression ---
> linreg is used for quantitative variable but not categorical
> linear regression can exceed 0 or 1 in a binary response
> the specific ordering of y is not equivalent in linreg

--- Logistic Regression ---
log(P/(1-P)) = bo+b1x
P(Y=1) = e^(b0+b1x)/(1+e^(b0+b1x))
*model the log-odds with linear function of predictors
*Likelihood of logistic regression, Newton-Rhason to maximise

--- KNN Classifier ---
Approach:
Use other variable observations that are most similar to it
Value of k cannot be too small (overfit) or too large (underfit)
D^2(xi, x0) = sigma(j=1 to p)((xi,j-x0,j)^2)

--- Support Vector Machine (SVC) ---
> Important example of 'kernel methods', by maximising margin around the
seperating hyperplane *(quadratic programming problems)
Classifier: f(xi)=sign(wT xi + b)
Functional margin of xi: yi(wT xi + b)
w: hyperplane normal vector, xi: data point i, yi: class label (1 or -1)
Distance r = y(wT x + b)/||w||
"

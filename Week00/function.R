"
R Function
"

# Build-in Function
vec <- c(10, 30, 70, 50, -10)
print(max(vec))
print(rank(vec))
print(sort(vec))
# Commonly used build-in functions:
# max(x), min(x), sum(x), mean(x), median(x), range(x)
# var(x), cor(x, y), sort(x), rank(x)

# User Defined Function
multiply <- function(num1, num2) {
    return(num1 * num2)
}
print(multiply(3, 7))

# Nested Function
nested_func <- function(x, y) {
    a <- x + y
    assign("gl", 100, envir = .GlobalEnv)
    return(a)
}
output <- nested_func(nested_func(1, 4), nested_func(2, 5))
print(output)
print(global) # this is a global var
# var defined outside of function are global variables
# you can define global var inside a function by <<-
# or you can use the example as shown above

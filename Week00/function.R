# Build-in Function
vec = c(10, 30, 70)
print(max(vec))
# Commonly used build-in functions:
# max(x), min(x), sum(x), mean(x), median(x), range(x)
# var(x), cor(x, y), sort(x), rank(x)

# User Defined Function
multiply <- function(num1, num2){
    return(num1 * num2)
}
print(multiply(3, 7))

# Nested Function
nested_func <- function(x, y){
    a <- x + y
    return(a)
}
output <- nested_func(nested_func(1, 4), nested_func(2, 5))
print(output)
# var defined outside of function are global variables
# you can define global var inside a function by <<-

"
R Function (Part 2)
"

# Optional argument with default values
announce <- function(message, count = 3, hi = FALSE) {
    print(ifelse(hi, "Hello!", "..."))
    for (a in 1:count) {
        print(message)
    }
}
announce("Welcome")
announce(toupper("The screen is off!"), hi = T)

# Dots argument
# define function that return: 1*arg1 + 2*arg2 + ... + n*argn
fun <- function(...) {
    l <- list(...)
    result <- 0
    count <- 1
    for (num in l) {
        result <- result + count * num
        count <- count + 1
    }
    return(result)
}
print(fun(5, 1, 4))

# Infix function
v1 <- c(1, 2, 3)
v2 <- c(4, 5, 6)
print(v1 %o% v2) # outer product of 2 vectors
# define infix function to calculate hcf of two numbers
"%hcf%" <- function(x, y) {
    if (x > y) {
        tmp <- x
        x <- y
        y <- tmp
    }
    for (i in c(1:x + 1)) {
        if (x %% i == 0 && y %% i == 0) {
            hcf <- i
        }
    }
    return(hcf)
}
print(42 %hcf% 4)

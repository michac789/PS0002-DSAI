"
R Conditional
"

# Conditional - IF ELSE
x <- 6
y <- TRUE
if (y && x >= 7) {
    print("statement1")
} else if (x == 6) {
    print("statement2")
} else {
    print("statement3")
}

# Conditional - Switch Case
option1 <- 3
switch(option1, {
        print("a")}, {
        print("b")}, {
        print("c")},
    )
switch(2, "op1", "op2", "op3")
option2 <- "goodbye"
reply <- switch(option2,
    "hello" = "welcome",
    "goodbye" = "see you later")
output <- cat(reply, name)
print(output)

# Conditional - Ternary
num <- if (2^2 == 1) "a" else "b"
print(num)
num2 <- ifelse((2^2 == 1), "a", "b")
print(num2)

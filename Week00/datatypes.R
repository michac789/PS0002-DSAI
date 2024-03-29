"
R Data Types & Operators
"

# Showing the different data type available from a list
data_list <- list(63, 43.7, 7L, -4 + 3i, "c", "any", FALSE, NA)
for (data in data_list) {
    text <- paste(data, class(data))
    print(text)
}

# Converting numbers data type (numeric, integer, complex)
x <- 9
print(class(x))
x <- as.integer(x)
y <- as.complex(x)
print(class(x))
print(class(y))

# Miscellaneous keywords
a <- Inf # infinity
b <- NaN # not a number
print(paste(class(a), class(b)))
print(is.finite(a))
print(is.nan(b))
print(is.na(NA)) # NA indicating not available / no values

"
Some common R operators:
Math operations: max, min, sqrt, abs, ceiling, floor, ..
sum, mean, median, range, var, cor, sort, rank, ...
String operations: cat, nchar, grepl, paste, <escape c>
Escape characters: \\, \n, \r, \t, \b
Arithmetic Operators: +, -, *, /, ^, %%, %/%
Assignment Operators: <-, <<-, ->, ->>
Comparison Operators: ==, !=, >, >=, <, <=
Logical Operators: &, &&, |, ||, !
Miscellaneous Operators: :, %in%, %*%
"

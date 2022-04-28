"
R Basic Data Structures
"
# Note: Matrix and Data Frame are to be discussed under Week 01 material

# List: collection of ordered and changeable data
foo <- list(TRUE, 6, "hello")
if (5 %in% foo) print("yeah") else print("boo")
# note: R indexing starts from 1
foo[1] <- FALSE
foo <- append(foo, "goodbye", after = 2) # add list item
print(foo)
foo <- foo[-1] # remove list item
print(foo)

# Vector: list of the same data type
vec <- c(3, TRUE, "study R") # all converted to 'character'
vec[5:7] <- c(12, 13, 14)
vec <- vec[vec != 12]
# numeric(a): vector of all 0 with length a
# rep(a, b): repeat a for b times
# seq(a, b, c): sequence of number from a to b inclusive, step c
vec2 <- c(10, NA, numeric(4), rep(2, 3), rep(1:2, 2),
    rep(c(5, 7), 2:3), seq(6, 10, 2))
print(vec2, na.print = "-1")
print(length(vec))
print(vec)
print(vec[6]) # indexing in vector
vec2 <- rep("yeah", 3) # replicates element using rep
print(vec2)

# Array: has 1 or more dimension compared to 2D matrix
arr <- array(3:7)
print(arr)
for (element in arr) {
    print(element)
}
print(arr[2]) # note: indexing starts at 1, not 0
# create 3d array
mularr <- array(c(seq(1, 12)), dim = c(2, 3, 4))
mularr[, 2, ] # access
mularr[, 3, 2]

# Factor: categorized vector
subject <- factor(c("Math", "Physics", "Chemistry", "Physics", "zzz"),
    levels = c("Math", "Physics", "Chemistry", "Biology"))
subject
length(subject)
subject[1]

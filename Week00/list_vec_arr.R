"
R Basic Data Structures I
"

# List: collection of ordered and changeable data
foo <- list(TRUE, 6, "hello")
if (5 %in% foo) print("yeah") else print("boo")
foo[1] <- FALSE
foo <- append(foo, "goodbye", after = 2) # add list item
print(foo)
foo <- foo[-1] # remove list item
print(foo)

# Vector: list of the same data type
vec <- c(3, TRUE, "study R") # all converted to 'character'
vec[5:7] <- c(12, 13, 14)
vec <- vec[vec != 12]
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

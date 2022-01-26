# Array
arr <- array(3:20)

# Vector
vec <- c(3, TRUE, "study R")
vec[5:7] = c(12, 13, 14)
vec <- vec[vec != 12]
print(length(vec))
print(vec)
print(vec[6])

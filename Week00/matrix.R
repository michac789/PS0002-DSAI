"
R Matrix
"

# Matrix basic operations in R
# Matrix: 2D dimensional structure of elements of the same data type
# defining matrix
mat <- matrix(c(1, 2, 3, 4, 5, 6), byrow = T, nrow = 2, ncol = 3)
# print whole matrix; byrow used to fill the matrix by row instead of column
print(mat)
print(mat[1, 3]) # print a single entry of a matrix
print(mat[2, ]) # print a whole row of a matrix
print(mat[, 3]) # print a whole column of a matrix
print(mat[, c(1, 2)]) # print column 1 and 2 of a matrix
mat <- cbind(mat, c(7, 8)) # add a new column to the matrix
mat <- rbind(mat, c(9, 10, 11, 12)) # add a new row to the matrix
print(mat)
mat <- mat[-c(1), -c(2)] # remove 1st row and 2nd column of the matrix
print(mat)
# use dim() to print a 1x2 matrix showing (height, width) of the matrix
print(dim(mat))
# print the number of entries of the matrix (height * width)
print(length(mat))
# use nrow() or ncol() that returns the number of row/column of a matrix
print(nrow(mat))
mat2 <- matrix(c(20, 21), nrow = 2, ncol = 1)
print(mat2)
# combining two matrix using rbind (by row) or cbind (by column)
mat3 <- cbind(mat, mat2)
print(mat3)
print(t(mat3)) # use t() for the transpose of matrix
mat4 <- mat %*% t(mat3[, 1:3]) # matrix multiplication
print(solve(mat4)) # inverse of matrix
print(solve(mat4) %*% mat4) # should equal to the identity matrix
mat5 <- diag(3) # construct 5x5 identity matrix
print(mat5)
mat6 <- diag(c(seq(4, 20, 8))) # construct diagonal matrix with those element
print(mat6)
print(mat5 * mat6) # component-wise multiplication (NOT matrix multiplication)

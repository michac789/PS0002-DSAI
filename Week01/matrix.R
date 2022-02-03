# Matrix basic operations in R
mat <- matrix(c(1, 2, 3, 4, 5, 6), byrow = T, nrow = 2, ncol = 3) # defining matrix
print(mat) # print whole matrix; byrow used to fill the matrix by row instead of column
print(mat[1, 3]) # print a single entry of a matrix
print(mat[2,]) # print a whole row of a matrix
print(mat[,3]) # print a whole column of a matrix
print(mat[,c(1, 2)]) # print column 1 and 2 of a matrix
mat <- cbind(mat, c(7, 8)) # add a new column to the matrix
mat <- rbind(mat, c(9, 10, 11, 12)) # add a new row to the 
print(mat)
mat <- mat[-c(1), -c(2)] # remove 1st row and 2nd column of the matrix
print(mat)
print(dim(mat)) # use dim() to print a 1x2 matrix showing (height, width) of the matrix
print(length(mat)) # print the number of entries of the matrix (height * width)
print(nrow(mat)) # use nrow() or ncol() that returns the number of row/column of a matrix
mat2 <- matrix(c('a', 'b'), nrow = 2, ncol = 1)
print(mat2)
mat3 <- cbind(mat, mat2) # combining two matrix using rbind (by row) or cbind (by column)
print(mat3)
print(t(mat3)) # use t() for the transpose of matrix

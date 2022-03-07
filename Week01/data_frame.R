# Data Frames in R
# Data Frame: similar to matrix, but can have different data types;
# rows for different observations, columns for different variables
# Launch these lines directly on R interactive

# Creating Data Frame
df <- data.frame(
    Name = c("Alex", "Ben", "Charlie", "Daven", "Egor"),
    Math_Score = c(78, 65, 89, 95, 56),
    English_Score = c(85, 79, 98, 67, 76)
)
a = c(seq(1, 4))
b = c(seq(5, 8))
df2 = data.frame(a, b)
names(df2) = c("n1", "n2") # specify column name
row.names(df2) = c("A", "B", "C", "D") # specify row name
df2

# Understanding Data Frame
df # print whole data frame
summary(df) # print summary of data frame
head(df, 2) # print the first 2 rows of the df, by default 6
dim(df) # print the dimension of the data frame
nrow(df) # print no of rows in the data frame
ncol(df) # print no of columns in the data frame
length(df) # print no of columns, similar to ncol
names(df) # print the column names
row.names(df) # print row names

# Accessing & Selecting Data Frame
df[2] # get the 2nd column in column format
df[,2] # get the 2nd column in a row (vector) format
df[,-2] # get every column except the 2nd column
df[2,] # get the 2nd row
df[2:4,] # get the 2nd to the 4th row only
df[2,3] # get the 2nd row, 3rd column
df$Name # print all the rows from the 'Name' column
select(df, 3) # select the third column
attach(df) # make the variable accessible by name
df[Math_Score > 60,]


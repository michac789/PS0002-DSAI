"
R Data Frame
"

# Data Frames in R
# Data Frame: similar to matrix, but can have different data types;
# rows for different observations, columns for different variables
# the data type for all elements in each column should be the same

# Note: Launch these lines directly on R interactive
# (through R Studio console, or R terminal in VS Code)

# Creating Data Frame
df <- data.frame(
    Name = c("Alex", "Ben", "Charlie", "Daven", "Egor"),
    Math_Score = c(78, 65, 89, 95, 56),
    English_Score = c(85, 79, 98, 67, 76)
)
# from vector to 2D matrix, then to data frame
v <- c(1:6) * 2
dim(v) <- c(2, 3)
df1 <- data.frame(v)
row.names(df1) <- c("Row1", "Row2")
df1
# from 2 or more vectors of same length to data frame
a <- c("Alex", "Ben", "Charlie", "Daven")
b <- c(12, 13, 13, 12)
df2 <- data.frame(a, b)
names(df2) <- c("Name", "Age") # specify column name
row.names(df2) <- c("A", "B", "C", "D") # specify row name
df2

# Understanding Data Frame
df # print whole data frame
summary(df) # print summary of data frame
head(df, 2) # print the first 2 rows of the df, by default 6
dim(df) # print the dimension of the data frame
nrow(df) # print no of rows in the data frame
ncol(df) # print no of columns in the data frame
length(df) # print no of columns, similar to ncol
str(df) # print all column data types and some value
names(df) # print the column names
row.names(df) # print row names

# Accessing Data Frame
df[2] # get the 2nd column in column format
df[, 2] # get the 2nd column in a row (vector) format
df[, -2] # get every column except the 2nd column
df[2, ] # get the 2nd row
df[2:4, ] # get the 2nd to the 4th row only
df[2, 3] # get the 2nd row, 3rd column
df[2, 3] = 100 # modify the 2nd row, 3rd column
df[1, seq(2, 3)] = c(77, 84) # modify the 2nd and 3rd column of the first row
df$Name # print all the rows from the 'Name' column
attach(df) # make the variable accessible by name instead of using '$'
df[Math_Score > 60, ]

# Select (Columns), Filter (Rows), Ordering
select(df, 3) # select the third column
select(df, Name, Math_Score) # select the columns: name, math_score
select(df, -English_Score) # same output as above
filter(df, Math_Score > 60 & English_Score < 90) # filter for rows
filter(df, Name %in% c("Ben", "Charlie"))
select(filter(df, Math_Score > 60 & English_Score < 90), Name)
df[order(Math_Score), ] # order based on math score
df[order(-English_Score), ] # order reverse based on english score
df[rev(order(English_Score)), ] # same as above

# Adding Data & Combining Data Frames
df3 <- rbind(df, c("Fafa", 89, 97)) # add new row; cbind for column
df3[order(Math_Score, rev(English_Score)), ]
df4 <- merge(df3, df2, by = "Name") # merge 2 data frames
df4

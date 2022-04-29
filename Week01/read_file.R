"
R Input File
"

# Reading Data Files
# scan(): read data into a vector or list from console or file
# read.table(): read data frames from free format text files
# read.fwf(): read files with fixed width format
# read.csv(): read data frames from csv files
# setwd(PATH): set working directory to 'PATH'
# getwd(): get current working directory

# Set working directory
setwd("C:/My Files/MY REPOSITORIES/PS0002/Week01")

# Scan: input through terminal, blank line indicates end of input
input <- scan(what = "") # looking for a string
input

# Read table: try ex1.3
varnames <- c("subject", "gender", "exam1", "exam2", "grade")
table <- read.table("assets/ex1.3.txt", header = F, col.names = varnames)
table

# Read fwf: try ex1.3fixed
fwf <- read.fwf("assets/ex1.3fixed.txt", width = c(2, 1, 3, 3, 1),
    col.names = varnames)
fwf

# Read csv: try ex1.3comma
csv <- read.csv("assets/ex1.3comma.txt", header = F, sep = "-")
csv

# Make use of dataframes
attach(table) # make the variables accessible by name
names(table) # print all the variables' name in a table
table # whole data frame in table format
table[2:4, ] # select (row, column)
table[exam1 > 85 & exam2 < 85, ] # select based on condition; '&' and, '|' or
# order ascendingly, use rev() for descending or '-'
table[order(exam2, -exam1), ]

# Output 'sink' function
# sink(<text file path>): send objects and text to a file
# cat(): prints the standard output connection

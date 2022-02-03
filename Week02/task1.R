# Lab 1 - Task 1

# Import packages & set working directory
# setwd("C:/My Files/MY REPOSITORIES/PS0002/Week02")
library(dplyr)

# a. Create a data frame 'lab1' by importing the 'lab1fixed.txt' file into R
var_lab1fixed <- c('id', 'gender', 'height', 'weight', 'siblings')
lab1 <- read.fwf("lab1fixed.txt", col.names = var_lab1fixed, width = c(3, 1, 3, 2, 1))
# plot(lab1$height, lab1$weight)

# b. Create a data frame 'lab1m' which contains all data for all male subjects
# how many males are there? ans=48
lab1m <- lab1[lab1[,2] == 'M',]
length(lab1m[,1])

# c. Imort lab1test, then merge lab1 and lab1test into a data frame 'lab1merge'
lab1test <- read.table("lab1test.txt", header = T)
lab1merge <- merge(lab1, lab1test, by = "id")
lab1merge[lab1merge[,3] > 182, 6]

# d. Remove record related to subject 211 from the data in new data frame 'lab1remo'
attach(lab1merge)
lab1remo <- lab1merge[id != 211,]

# e. Change 'lab1' subject 211 weight from 80kg to 60kg
lab1[id == 211, 4] = 80

# f. Who is the second tallest female in this group and what are her height, weight, test score?
# ans = no73, height = 174, weight = 64, test = 57
lab1fsort <- lab1merge[gender == 'F',]
lab1fsort <- lab1fsort[rev(order(lab1fsort[,3])),]
lab1fsort[2, c(3, 4, 6)]

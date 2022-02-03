
library(dplyr)

# a. Create a data frame 'lab1' by importing the 'lab1fixed.txt' file into R
var_lab1fixed <- c('id', 'gender', 'height', 'weight', 'siblings')
lab1 <- read.fwf("lab1fixed.txt", col.names = var_lab1fixed, width = c(3, 1, 3, 2, 1))

# b. Create a data frame 'lab1m' which contains all data for all male subjects
# how many males are there? ans=48
lab1m <- lab1 %>% filter(gender == 'M')
males_count <- lab1m %>% summarise(id = n())
print(males_count)

print(lab1m[2])

# c. Merge lab1 and lab1test into a data frame 'lab1merge'
#var_lab <- c('id', 'test')


#plot(lab1$height, lab1$weight)


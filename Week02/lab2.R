# Lab 2
# Data source: https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/msleep_ggplot2.csv

# Import packages & set working directory
# setwd("C:/My Files/MY REPOSITORIES/PS0002/Week03")
library(dplyr)

# Read data into a dataframe using read.csv
df <- read.csv("msleep_ggplot2.csv")

# 1. Check the number of rows and columns using dim()
dim(df)

# 2. Show summary of all columns in the dataset using summary()
summary(df)

# 3. Show the first 10 rows using function head()
head(df, 10)

# 4. Using dplyr verb 'select':
# • select a set of columns: the “name” and the “sleep_total” columns 
# • select all the columns except a specific column, use the “-“ (subtraction) operator 
# • select a range of columns by name, use the “:” (colon) operator
# • select all columns that start with the character string “sl”, use the function starts_with()
attach(df)
select(df, name, sleep_total)
select(df, -name)
select(df, name:order)
select(df, starts_with("sl"))

# 5. Using dplyr verb 'filter':
# • Filter the rows for mammals that sleep a total of more than 16 hours. 
# • Filter the rows for mammals that sleep a total of more than 16 hours and have a 
# body weight of greater than 1 kilogram.
# • Filter the rows for mammals with order as “Perissodactyla” and “Primates” 
filter(df, sleep_total > 16)
filter(df, sleep_total > 16 & bodywt > 1)
filter(df, order == 'Perissodactyla' | order == 'Primates')

# 6. Using pipe operator:
# • Select two columns (name and sleep_total), show the first 6 rows of the selected data frame
df %>% select(name, sleep_total) %>% head

# 7. Using arrange():
# • Select three columns from sleepdata, arrange the rows by the order and then 
# arrange the rows by sleep_total. Finally filter the rows for mammals that sleep for 
# 16 or more hours
# • Change the order of sleep_total column to a descending order using the 
# function desc() in the step above
df %>% select(order, sleep_total, sleep_rem, sleep_cycle) %>%
    arrange(order, desc(sleep_total)) %>%
    filter(sleep_total >= 16)

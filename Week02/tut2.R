# Tutorial 2

# DPLYR Package - Select, Filter, Arrange, Group By, Pipe Operator
# Download R packages
# Load packages
library(dplyr)
library(nycflights13)

### Selecting ###
# select those columns
select(flights, year, month, day)
# select columns between year and day
select(flights, year:day) 
# select all columns except those between year and day, use the “-“(subtraction) operator
select(flights, -(year:day))
# select all columns end with the character string “time”
select(flights, ends_with("time")) 
# other options: starts_with, ends_with, contains, matches, one_of

### Filtering ###
# filter the rows for flights in the second half of January.
filter(flights, month == 1, day>=16)
# equivalence in normal R code:
flights[flights$month==1 &flights$day>=16,]
# filter the rows for flights with carrier as “AA” and “UA”.
filter(flights, carrier %in% c("AA", "UA"))

### Arranging ###
arrange(flights, arr_time)
# arrange in descending order using function desc() or '-' sign
arrange(flights, -arr_time)

### Pipe Operator ###
flights %>% select(year, month, day) %>% head
# equivalent to nested verbs:
head(select(flights, year, month, day))
# aesthetic for longer code
flights %>% 
    select(year:flight) %>% 
    arrange(arr_time, arr_delay) %>%
    filter(arr_delay>=4)

### Grouping ###
bycarrier <- flights %>% group_by (carrier)
summarise(bycarrier, count=n(), delay = mean(arr_delay, na.rm=TRUE)) 

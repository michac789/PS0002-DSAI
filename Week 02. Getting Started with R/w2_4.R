# Week 2 - 4: Sorting, selecting, comparing using 'dplyr' package

"
arrange(): arrange data ascendingly be default, use desc() for descending
-- using boxplot for the graph --
"

# Load packages, objects, select then arrange descendingly based on numflights
library(nycflights13)
library(dplyr)
library(lubridate)
airportmonthlycounts <- flights %>%
    filter(dest %in% c('ALB', 'BDL', 'BTV')) %>%
    group_by(year, month, dest) %>%
    summarise(numflights = n()) %>%
    mutate(FirstOfMonth = ymd(paste(year, "-", month, "-01", sep=""))) %>%
    arrange(desc(numflights))
print(airportmonthlycounts)

# Comparing airlines example
jandelays <- flights %>%
    select(origin, dest, year, month, day, carrier, arr_delay) %>%
    filter(origin == 'JFK' & dest == 'MSP' & month == 1)
print(jandelays)
graph <- ggplot(data = jandelays, aes(x = carrier, y = arr_delay)) + geom_boxplot()
print(graph)

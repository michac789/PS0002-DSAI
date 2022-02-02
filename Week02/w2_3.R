# Week 2 - 3: Plotting graph using 'ggplot2' package

"
Get the 'ymd' function by installing 'lubridate' package (year month date format)
Install 'ggplot' package to plot data on a graph
Use R Studio to load and download graph, or use R in VS Code
"

# Load object
library(nycflights13)
library(dplyr)
library(lubridate)
airportdailycounts <- flights %>%
    filter(dest %in% c('ALB', 'BDL', 'BTV')) %>%
    group_by(year, month, day, dest) %>%
    summarise(numflights = n()) %>%
    mutate(date = ymd(paste(year, month, day, sep = "-")))
print(airportdailycounts)

# Plot graph 1 based on first object
library(ggplot2)
graph1 <- ggplot(data = airportdailycounts, aes(x = date, y = numflights, colour = dest)) + geom_point()
print(graph1)

# Load and plot graph 2 based on second object
airportmonthlycounts <- flights %>%
    filter(dest %in% c('ALB', 'BDL', 'BTV')) %>%
    group_by(year, month, dest) %>%
    summarise(numflights = n()) %>%
    mutate(FirstOfMonth = ymd(paste(year, "-", month, "-01", sep="")))
print(airportmonthlycounts)
graph2 <- ggplot(data = airportmonthlycounts, aes(x = FirstOfMonth, y = numflights, colour = dest)) + geom_point()
print(graph2)

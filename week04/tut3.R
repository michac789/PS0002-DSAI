# Tutorial 3

# Load Packages
library(nycflights13)
library(dplyr)
library(ggplot2)

### Mutate & Transmute ###
# mutate to add var, transmute to keep new var only
mutate(flights, gain = arr_delay - dep_delay, speed = distance / (air_time) / 60))
transmute(flights, gain = arr_delay - dep_delay, gain_rate = gain / (air_time / 60))

### Summarise ###
# collapses to a single row, creating summary statistics
# other function: sd, min, max, median, sum, n, first, last, n_distinct, etc
summarise(flights, mean(dep_delay, na.rm = TRUE), mean(arr_delay, na.rm = TRUE))
summarise(flights, avg_delay = mean(dep_delay, na.rm=TRUE), 
    min_delay = min(dep_delay, na.rm=TRUE),
    max_delay = max(dep_delay, na.rm=TRUE),
    total = n())
rg <- function(x){
    xe <- na.omit(x) # remove NA’s from x
    max(xe) - min(xe)
}
summarise(flights, count=n(), rg(dep_delay), mean(dep_delay,na.rm=TRUE))

### Group By ###
# nothing happens to original data, but when summarised it will be grouped
bycarrier <- group_by(flights, carrier)
delay <- summarise(bycarrier, count = n(), dist = mean(distance, na.rm=TRUE),
    delay = mean(dep_delay, na.rm = TRUE))

### Data Visualization ###
# ggplot(<dataframe>, aes(...)) + geom_point() + ...
# aes: indicate x, y, color, size, shape, height, etc
# geometry: graphics type (histogram, box plot, line plot, density plot, dot plot, etc)

## Scatter Plot ##
# shows the relationship between two variables
# Init ggplot
ggplot(delay, aes(x = dist, y = delay))
# add points using a geom layer called geom_point
ggplot(delay, aes(x = dist, y = delay)) + geom_point()
# add a smoothing curve by geom_smooth () 
ggplot(delay, aes(x = dist, y = delay)) + geom_point() + geom_smooth() 
# or linear curve by geom_smooth (method = 'lm')
ggplot(delay, aes(x = dist, y = delay)) + geom_point() + geom_smooth(method = 'lm') 
# change the color and size of points
ggplot(delay, aes(x = dist, y = delay)) +
    geom_point(col = "red", size = 3) + geom_smooth()
# varying color and size by other variables in the data frame
ggplot(delay, aes(dist, delay)) + 
    geom_point(aes(col = carrier, size = count)) + geom_smooth()

## Box Plot ##
# used to compare multiple groups of dat
# ex1: compare carrier AA and UA in overall arrival delay in Jan 2013
flights1 <- filter(flights, carrier %in% c("AA", "UA"), month == 1)
ggplot(flights1, aes(x = carrier, y = arr_delay)) + geom_boxplot()
# ex2: identify which airline is most reliable flying from New York to MSP on Jan 2013
jandelays <- flights %>% 
    select(origin, dest, month, day, carrier, arr_delay) %>%
    filter(dest == "MSP" & month == 1)
ggplot(jandelays, aes(x = carrier, y = arr_delay)) + geom_boxplot()

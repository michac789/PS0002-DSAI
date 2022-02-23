# Exploratory Data Analaysis (EDA) 13

# Import the required packages
library(nycflights13)
library(dplyr)
library(ggplot2)
library(psych)

# Bar Chart
# Syntax: geom_bar(data=NULL, stat="bin", position="stack", ..)
# stat: bin (number of cases), identity (value in each group)
flights %>% group_by(carrier) %>%
    summarise(ave_delay = mean(dep_delay, na.rm=T)) %>%
    ggplot(aes(x=carrier, y=ave_delay)) + geom_bar(stat='identity')

# Box Plot
# Scaling to get better picture: ylim(start, end)
flights %>% group_by(carrier) %>%
    ggplot(aes(x=carrier, y=dep_delay)) + geom_boxplot() + ylim(0, 100)
# Are flight delays from OO, EV and YV worse at some airport than others?
flights %>% filter(carrier %in% c('EV', 'OO', 'YV')) %>%
    group_by(carrier) %>%
    ggplot(aes(x=carrier, y=dep_delay)) + geom_boxplot() + ylim(0, 100)
# Using 'fill' in boxplot
flights %>% filter(carrier %in% c('EV', 'OO', 'YV')) %>%
    ggplot(aes(x=origin, y=dep_delay, fill=carrier)) + geom_boxplot() + ylim(0, 100)

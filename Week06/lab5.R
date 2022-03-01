# Lab 5

# 1. Load and prepare data
library(nycflights13)
library(dplyr)
summary(flights)
df <- flights %>%
    mutate(gain_of_delay = arr_delay - dep_delay) %>%
    filter(air_time > 550)
df <- df[c('air_time','gain_of_delay')]
summary(df)

# 2. Visualize gain and air_time using 
plot(df[['air_time']], df[['gain_of_delay']])





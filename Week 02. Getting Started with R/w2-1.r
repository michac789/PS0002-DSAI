# Week 2 - 1: Install and using external package

# In R studio, click tools -> install packages -> 'nycflights13' and 'dplyr'
# ls() to see all the available objects
# rm(<obj>) to remove an object / some objects
# rm(list = ls()) to remove all objects
library(nycflights13)
print(flights)
print(planes)
print(weather)
print(airlines)
print(airports)

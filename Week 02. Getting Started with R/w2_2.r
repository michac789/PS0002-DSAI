# Week 2 - 2: Filtering, grouping, aggregating using 'dplyr' package

"
'dplyr' provides simple functions for data manipulation actions

Some basic data manipulation operations:
select(): select variables (columns)
filter(): subset observations (rows)
mutate(): add new variables (columns)
arrange(): reorder the observations
summarise(): reduce data to a single row
group_by(): aggregate (combine) data
left_join(): merge two data objects
distinct(): remove duplicate entries
collect(): force computation, bring data back
"

library(dplyr)
data1 <- airports %>% select(name, lat) %>% filter(name == "Randall Airport")
data2 <- airports %>% filter(faa %in% c('ALB', 'BDL', 'BTV'))
data3 <- flights %>% group_by(arr_time) %>% arrange(arr_time, dep_time)
data4 <- flights %>% summarise(numfligths = n()) # n() counts rows
data5 <- flights %>%
    filter(dest %in% c('ALB', 'BDL', 'BTV')) %>%
    group_by(year, month, dest) %>%
    summarise(numflights = n())
print(data1)
print(data2)
print(data3)
print(data4)
print(data5)

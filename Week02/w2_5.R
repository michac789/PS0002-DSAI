# Week 2 - 4: Merging and data cleaning

"
Relational databases using SQL basic operators:
SELECT: create new result from table
FROM: specify table
WHERE: subset observations
GROUP BY: aggregate
ORDER: re-order the observations
DISTINCT: remove duplicate values
JOIN: merge two data objects

Data cleaning / scrubbing:
process of deleting and correcting inaccurate records

Tools:
programming language (R in this case)
OpenRefine http://openrefine.org
Tableau http://www.tableau.com
"

# Merging data
jandelays <- flights %>%
    select(origin, dest, year, month, day, carrier, arr_delay) %>%
    filter(origin == 'JFK' & dest == 'MSP' & month == 1)
print(jandelays)
merged <- left_join(jandelays, airlines, by = c("carrier" = "carrier"))
print(merged)

# Lab 3 (Assignment 1)
# Note: please install these required packages first: dplyr, ggplot2

# Load the required packages
library(dplyr)
library(ggplot2)

# View descriptive summary, allow to access variable name
summary(msleep)
attach(msleep)

# 1. Create dataframe 'sleep1', include all variables except name, genus, conservation,
# for mammals with body weight falling into interval [0.1, 100]
sleep1 <- msleep %>%
    select(-name, -genus, -conservation) %>%
    filter(0.1 <= bodywt & bodywt <= 100)

# 2. Add two new variables in dataframe 'sleep1', 
# 'rem_ratio': percentage of rem sleep to total sleep
# 'diff_sw': difference between time spent awake and total sleep time
sleep1 <- sleep1 %>%
    mutate(rem_ratio = sleep_rem / sleep_total, diff_sw = awake - sleep_total)

# 3. Find the summary statistics for dataframe 'sleep1':
# • number of mammals
# • average of (rem_ratio, diff_sw, body weight over different vore groups)
# • briefly comment the comparison between vore groups
summary_stats1 <- sleep1 %>%
    summarise(num_mammals = n(), avg_remratio = mean(rem_ratio, na.rm = T),
    avg_diffsw = mean(diff_sw, na.rm = T))
summary_stats2 <- sleep1 %>%
    group_by(vore) %>%
    summarise(ave_bodywt = mean(bodywt, na.rm = T))
summary_stats1
summary_stats2
# Comment:
# 

# 4. Use an appropriate plot to represent the distribution of:
# rem_ratio over different vore groups, repeat for diff_sw
# • briefly comment how different each variable distributes for different vore groups

# TODO

# 5.

# TODO
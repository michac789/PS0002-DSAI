# Lab 3 (Assignment 1)
# Note: please install these required packages first (dplyr, ggplot2)

# Load the required packages
library(dplyr)
library(ggplot2)

# View descriptive summary
summary(msleep)

# 1. Create dataframe 'sleep1', include all variables except name, genus, conservation,
# for mammals with body weight falling into interval [0.1, 100]
sleep1 <- msleep %>%
    select(-name, -genus, -conservation) %>%
    filter(0.1 <= bodywt & bodywt <= 100)

# 2. Add two new variables in dataframe 'sleep1', 
# 'rem_ratio': percentage of rem sleep to total sleep
# 'diff_sw': difference between time spent awake and total sleep time
sleep1 <- sleep1 %>%
    mutate(rem_ratio = (sleep_rem / sleep_total) * 100, diff_sw = awake - sleep_total)

# 3. Find the summary statistics for dataframe 'sleep1':
# • number of mammals
# • average of (rem_ratio, diff_sw, body weight over different vore groups)
# • briefly comment the comparison between vore groups
summary_stats1 <- sleep1 %>%
    summarise(num_mammals = n(), avg_remratio = mean(rem_ratio, na.rm = T),
    avg_diffsw = mean(diff_sw, na.rm = T))
sleep1_vore <- sleep1 %>% group_by(vore)
summary_stats2 <- sleep1_vore %>%
    summarise(ave_bodywt = mean(bodywt, na.rm = T))
summary_stats1
summary_stats2
# Comment:
# On average, insectivore and carnivore has the highest body weight, followed by
# omnivore that has moderate body weight, herbivore with lighter body weight, and
# the unclassified (NA) group has the least average body weight.

# 4. Use an appropriate plot to represent the distribution of:
# rem_ratio over different vore groups, repeat for diff_sw
# • briefly comment how different each variable distributes for different vore groups
sleep1_vore <- sleep1_vore %>% filter(!is.na(rem_ratio), !is.na(diff_sw))
ggplot(sleep1_vore, aes(x = vore, y = rem_ratio)) + geom_boxplot()
ggplot(sleep1_vore, aes(x = vore, y = diff_sw)) + geom_boxplot()
# Comment:
# The rem_ratio is quite distributed apart across different vore groups,
# herbivore generally has lower rem ratio, carnivore has generally higher rem ratio,
# insectivore has a packed and a very high rem ratio amongst the other vore type,
# omnivore has a moderate rem ratio and has the most widely distributed ratio
# Meanwhile, the difference between time awake and sleep time (diff_sw) is more closely
# distributed between the various vore groups. Almost all carnivore has a positive diff_sw,
# which means that they are more likely to be awake then asleep, while herbivore has a more
# spreadout distribution both negative & positive difference, insectivore generally sleeps more
# than they are awake, most omnivores sleep less than awake there are a very few outliers

# 5. Use two appropriate plots to visualize relationship between:
# rem ratio and body weight, diff_sw and body weight
# • briefly comment the relationship from each plot
sleep1noNA <- sleep1 %>% filter(!is.na(rem_ratio), !is.na(diff_sw), !is.na(bodywt))
ggplot(sleep1noNA, aes(x = bodywt, y = rem_ratio)) + geom_point() + geom_smooth(method = 'lm')
# ggplot(sleep1noNA, aes(x = bodywt, y = rem_ratio)) + geom_point() + geom_smooth()
ggplot(sleep1noNA, aes(x = bodywt, y = diff_sw)) + geom_point() + geom_smooth(method = 'lm')
# Comment:
# The relationship of the first plot is preety vague and random, though generally there is a slight
# increase of rem_ratio when body weight increases (when using a linear line), but when we do not use
# a linear line it seems that there is no specific or strong correlation between body weight and
# the rem ratio.
# The second plot has a slight positive correlation between the increase of body weight and the
# difference between awake and sleep hours. Most mammals represented from the data with small weight
# has a preety random and spreadout sleep time difference, while heavier animals tend to have a positive
# diff_sw value, though with an outlier present.

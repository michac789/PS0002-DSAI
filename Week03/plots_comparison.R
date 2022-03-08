# Plots Comparison

# Set working directory & import required packages
# setwd("C:/My Files/MY REPOSITORIES/PS0002/Week03")
library(AmesHousing)
library(ggplot2)
library(gridExtra)
ames <- AmesHousing::make_ames()

# Relationships between continuous and categorical variable
p1 <- ggplot(ames, aes(x = factor(Bedroom_AbvGr), y = Sale_Price)) +
    geom_point(alpha = .2)
p2 <- ggplot(ames, aes(x = factor(Bedroom_AbvGr), y = Sale_Price)) +
    geom_jitter(alpha = .2, width = .2)
p3 <- ggplot(ames, aes(x = factor(Bedroom_AbvGr), y = Sale_Price)) +
    geom_boxplot()
p4 <- ggplot(ames, aes(x = factor(Bedroom_AbvGr), y = Sale_Price)) +
    geom_violin()
gridExtra::grid.arrange(p1, p2, p3, p4, nrow = 2)

# Relationship between multiple variable
ggplot(ames, aes(x = Gr_Liv_Area, y = Sale_Price, color = Central_Air, shape = Central_Air)) +
    geom_point() +
    scale_x_continuous(trans = scales::log_trans()) +
    scale_y_continuous(trans = scales::log_trans())

# Scatterplot matrix
ggplot(ames, aes(x = Gr_Liv_Area, y = Sale_Price)) +
    geom_point(alpha = .3) +
    scale_x_log10() +
    scale_y_log10(labels = scales::dollar) +
    facet_wrap(~ House_Style, nrow = 2) +
    theme_bw()

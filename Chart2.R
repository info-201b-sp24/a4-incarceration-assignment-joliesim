library(ggplot2)
library(dplyr)
library(stringr)
library(tidyverse)

data <- read.csv("https://raw.githubusercontent.com/melaniewalsh/Neat-Datasets/main/us-prison-pop.csv")
prison_data <- na.omit(data)

updated_data <- prison_data %>%
  select("urbanicity", "total_prison_pop")

max_populations <- updated_data %>%
  group_by(urbanicity) %>%
  summarize(average_value = mean(total_prison_pop))

ggplot(max_populations, aes(x = urbanicity, y = average_value)) +
  geom_bar(stat = "identity") +
  labs(title = "Average Prison Population of County Urbanicities",
      x = "Urbanicity",
      y = "Average Prison Population") +
  scale_y_continuous(breaks = seq(0, 9500, by = 1500))
  theme_minimal()
library(ggplot2)
library(dplyr)
library(stringr)
library(tidyverse)

data <- read.csv("https://raw.githubusercontent.com/melaniewalsh/Neat-Datasets/main/us-prison-pop.csv")
prison_data <- na.omit(data)

ethnic_group_pops <- prison_data %>%
  select("year", "aapi_prison_pop", "black_prison_pop", "latinx_prison_pop", "native_prison_pop", "other_race_prison_pop","white_prison_pop")

pops_over_time <- ethnic_group_pops %>%
  group_by(year) %>%
  summarize(across("aapi_prison_pop":"white_prison_pop", sum, na.rm = TRUE))

data_long <- pops_over_time %>%
  pivot_longer(
    cols = -year,
    names_to = "ethnic_group",
    values_to = "population"
  )

ggplot(data_long, aes(x = year, y = population, color = ethnic_group)) +
  geom_path(stat = "identity") +
  labs(title = "Total Prison Population of Ethnic Groups Over Time",
       x = "Year",
       y = "Total Population",
       color = "Ethnic Group") +
  scale_x_continuous(breaks = seq(1990, 2016, by = 2)) +
  theme_minimal() + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

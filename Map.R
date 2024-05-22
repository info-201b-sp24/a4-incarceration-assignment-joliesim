library(ggplot2)
library(dplyr)
library(stringr)
library(tidyverse)
library(maps)
install.packages("tigris")
data <- read.csv("https://raw.githubusercontent.com/melaniewalsh/Neat-Datasets/main/us-prison-pop.csv")
prison_data <- na.omit(data)

new_data <- prison_data %>%
  select("state", "county_name", "black_male_prison_pop")

wa_pops <- new_data %>%
  filter(grepl("WA", state))

max_black_male_pop <- wa_pops %>%
  group_by(county_name) %>%
  summarize(max_pop = max(black_male_prison_pop))

library(tigris)

wa_counties_data <- left_join(wa_counties, max_black_male_pop, by = c("NAME" = "county_name"))

ggplot() +
  geom_sf(data = wa_counties_data, aes(fill = max_pop)) +
  scale_fill_gradient(name = "Max Black Male Prison Population",
                      low = "lightblue", high = "darkblue", na.value = "grey",
                      guide = "legend") +
  labs(title = "Max Black Male Prison Population by County in Washington State") +
  theme_minimal()


library(ggplot2)
library(dplyr)

data <- read.csv("https://raw.githubusercontent.com/melaniewalsh/Neat-Datasets/main/us-prison-pop.csv")
prison_data <- na.omit(data)

new_data <- prison_data %>%
  select("state", "county_name", "black_male_prison_pop")

wa_pops <- new_data %>%
  filter(grepl("WA", state))

max_black_male_pop <- wa_pops %>%
  group_by(county_name) %>%
  summarize(max_pop = max(black_male_prison_pop))

updated_data <- max_black_male_pop %>%
  mutate(county = tolower(county_name)) %>%
  mutate(county_official = gsub(" county", "", county))

wa_shape <- map_data('county', 'washington')

state_shape <- wa_shape %>%
  left_join(updated_data, by = c("subregion" = "county_official"))

ggplot(state_shape) +
  geom_polygon(
    mapping = aes(x = long, y = lat, group = group, fill = max_pop), 
    color = "white",
    linewidth = .1
  ) +
  coord_map() +
  scale_fill_continuous(low = "blue", high = "darkblue", na.value = "lightblue") +
  labs(fill = "Black Male Prison Population",
       title = "Distribution of Black Male Prison Population in Washington State Counties As of 2016") +
  theme(axis.title = element_blank(), 
        axis.text = element_blank(), 
        axis.ticks = element_blank())
         

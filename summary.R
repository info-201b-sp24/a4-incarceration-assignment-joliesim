library(dplyr)
library(stringr)
library(ggplot2)
library(tidyverse)

data <- read.csv("https://raw.githubusercontent.com/melaniewalsh/Neat-Datasets/main/us-prison-pop.csv")

summary_info <- list(
  iqr_white_pop = IQR(data$white_prison_pop, na.rm = TRUE),
  avg_total_prison_pop = mean(data$total_prison_pop, na.rm = TRUE),
  max_black_pop = max(data$black_prison_pop, na.rm = TRUE),
  min_black_pop = min(data$black_prison_pop[data$black_prison_pop !=0], na.rm = TRUE),
  avg_black_male_pop = mean(data$black_male_prison_pop, na.rm = TRUE)
)

summary_info
 
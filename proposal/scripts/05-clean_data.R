#### Preamble ####
# Purpose: Cleans the raw data produced by 02-download_data.R
# Author: Onon Burentuvshin
# Date: 27 November 2024
# Contact: onon.burentuvshin@mail.utoronto.ca
# License: MIT
# Pre-requisites: Make sure to have the original data set.


#### Workspace setup ####
library(tidyverse)
library(readr)
library(dplyr)
library(arrow)
library(janitor)


#### Load data ####
sleep_data <- read_csv("data/02-raw_data/sleep_cycle_productivity.csv") %>%
  clean_names()  

names(sleep_data)

# Drop variables that we are not using #
sleep_clean <- sleep_data %>%
  select(-c(date, sleep_start_time, sleep_end_time, person_id)) %>%
  na.omit() %>%  
  mutate(
    exercise_cat = cut(exercise_mins_day,
                       breaks = c(0, 30, 60, Inf),
                       labels = c("low", "medium", "high"),
                       include.lowest = TRUE),
    gender = factor(gender, 
                    levels = c("Male", "Female", "Other"),
                    ordered = FALSE)
  )




#### Save data ####
write_csv(sleep_clean, "data/04-analysis_data/clean_data.csv")

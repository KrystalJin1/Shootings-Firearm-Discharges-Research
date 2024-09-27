#### Preamble ####
# Purpose: Cleans the raw plane data
# Author: Jin Zhang
# Date: 25 September 2024
# Contact: kry.zhang@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Any other information needed? None

#### Workspace setup ####
library(tidyverse)

#### Clean data ####
raw_data <- read_csv("data/raw_data/Shootings_data.csv")

cleaned_data <-
  raw_data |>
  janitor::clean_names() |>
  select(
    occ_year, occ_month, occ_hour, occ_time_range,
    death, injuries, geometry
  ) |>
  # Rename columns for better clarity
  rename(
    year = occ_year,
    month = occ_month,
    hour = occ_hour,
    time_range = occ_time_range,
  ) |>
  # Convert DEATH and INJURIES to numeric and handle missing values
  mutate(
    death = as.numeric(death),
    injuries = as.numeric(injuries),

    # Replace NA with 0 and calculate total_people
    total_people = ifelse(is.na(death), 0, death) + ifelse(is.na(injuries), 0, injuries)
  )

# Split the geometry column into Longitude and Latitude
cleaned_data <- cleaned_data %>%
  separate(geometry, into = c("Longitude", "Latitude"), sep = ", ", convert = TRUE) %>%
  mutate(
    Longitude = as.numeric(gsub("c\\(", "", Longitude)), # Remove 'c(' and convert to numeric
    Latitude = as.numeric(gsub("\\)", "", Latitude))
  ) # Remove ')' and convert to numeric

# Save cleaned dataset to a CSV file
write_csv(cleaned_data, "data/analysis_data/cleaned_shootings_data.csv")

#### Preamble ####
# Purpose: Simulates a dataset similar to your Toronto Shootings and Firearm Discharges data
# Author: Jin Zhang
# Date: 23 September 2024
# Contact: kry.zhang@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Any other information needed? None

#### Workspace setup ####
library(tidyverse)

set.seed(1008184288)

#### Simulate data ####

# Simulation parameters
start_date <- as.Date("2018-01-01")
end_date <- as.Date("2023-12-31")
number_of_events <- 5000

# Simulated event identifiers
ids <- 1:number_of_events
event_unique_ids <- paste0("EVT-", formatC(ids, width = 6, flag = "0"))

# Simulated dates and times
occ_dates <- as.Date(runif(number_of_events, min = as.numeric(start_date), max = as.numeric(end_date)), origin = "1970-01-01")
occ_years <- format(occ_dates, "%Y")
occ_months <- format(occ_dates, "%B")
occ_dow <- weekdays(occ_dates)
occ_doy <- as.integer(format(occ_dates, "%j"))
occ_day <- as.integer(format(occ_dates, "%d"))
occ_hours <- sample(0:23, number_of_events, replace = TRUE)
occ_time_range <- cut(occ_hours, breaks = c(0, 6, 12, 18, 24), labels = c("Night", "Morning", "Afternoon", "Evening"), include.lowest = TRUE)

# Simulated divisions and neighborhoods
divisions <- sample(paste0("D", sprintf("%02d", 1:54)), number_of_events, replace = TRUE)
neighbourhoods_158 <- c("Downtown", "Scarborough", "North York", "Etobicoke", "East York")
hood_158 <- sample(1:158, number_of_events, replace = TRUE)
neighbourhoods_140 <- sample(neighbourhoods_158, number_of_events, replace = TRUE)
hood_140 <- sample(1:140, number_of_events, replace = TRUE)

# Simulated casualties
deaths <- rbinom(number_of_events, size = 1, prob = 0.05)
injuries <- rpois(number_of_events, lambda = 2)

# Simulated spatial geometry (mock latitude and longitude)
longitudes <- runif(number_of_events, min = -79.6393, max = -79.1169) # Example Toronto range
latitudes <- runif(number_of_events, min = 43.5810, max = 43.8554)
geometry <- paste0("c(", longitudes, ", ", latitudes, ")")

# Generate the dataset
simulated_data <- tibble(
  id = ids,
  EVENT_UNIQUE_ID = event_unique_ids,
  OCC_DATE = occ_dates,
  OCC_YEAR = occ_years,
  OCC_MONTH = occ_months,
  OCC_DOW = occ_dow,
  OCC_DOY = occ_doy,
  OCC_DAY = occ_day,
  OCC_HOUR = occ_hours,
  OCC_TIME_RANGE = occ_time_range,
  DIVISION = divisions,
  DEATH = deaths,
  INJURIES = injuries,
  HOOD_158 = hood_158,
  NEIGHBOURHOOD_158 = sample(neighbourhoods_158, number_of_events, replace = TRUE),
  HOOD_140 = hood_140,
  NEIGHBOURHOOD_140 = neighbourhoods_140,
  geometry = geometry
)

# Print the first few rows
print(head(simulated_data))

# Write the simulated data to a CSV file
write.csv(simulated_data, "data/simulated_toronto_data.csv", row.names = FALSE)

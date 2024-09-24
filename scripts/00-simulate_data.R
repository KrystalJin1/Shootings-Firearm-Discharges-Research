#### Preamble ####
# Purpose: Simulates Toronto Shootings and Firearm Discharges data
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

start_date <- as.Date("2018-01-01")
end_date <- as.Date("2023-12-31")

number_of_dates <- 1000

event_types <- sample(c("shooting_event", "firearm_discharge"), 
                      number_of_dates, replace = TRUE)

# Simulated date
dates <- as.Date(
  runif(n = number_of_dates,
        min = as.numeric(start_date),
        max = as.numeric(end_date)),
  origin = "1970-01-01"
)

#Simulated community
neighbourhoods <- c("Downtown", "Scarborough", "North York", "Etobicoke", "East York")
random_neighbourhoods <- sample(neighbourhoods, number_of_dates, replace = TRUE)

#Simulated number of casualties and fatalities
injuries <- ifelse(event_types == "shooting_event", rpois(number_of_dates, lambda = 1), 0)
deaths <- ifelse(event_types == "shooting_event", rbinom(number_of_dates, 1, 0.1), 0)

# Generate data
data <- tibble(
  dates = dates,
  event_type = event_types,
  neighbourhood = random_neighbourhoods,
  injuries = injuries,
  deaths = deaths
)

print(head(data))

write.csv()



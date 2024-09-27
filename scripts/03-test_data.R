#### Preamble ####
# Purpose: Tests the simulated data
# Author: Jin Zhang
# Date: 25 September 2024
# Contact: kry.zhang@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Any other information needed? None
style_file(path = "scripts/02-data_cleaning.R")


#### Workspace setup ####
library(tidyverse)

#### Test data ####
# Test 1: Check if the minimum year in OCC_YEAR is 2004 and the maximum year is 2024
sim_data <- read.csv("data/simulated_toronto_data.csv")
sim_data$OCC_YEAR |> min() == 2004
sim_data$OCC_YEAR |> max() == 2024

# Test 2: Check if the minimum hour in OCC_HOUR is 0 and the maximum is 23
sim_data <- read.csv("data/simulated_toronto_data.csv")
sim_data$OCC_HOUR |> min() == 0
sim_data$OCC_HOUR |> max() == 23

# Test 3: Check if all values in INJURIES column are non-negative
test_injuries_non_negative <- all(sim_data$INJURIES >= 0)
print(paste("Test injuries are non-negative:", test_injuries_non_negative))

# Test 4: Check if all values in NEIGHBOURHOOD_158 column are valid neighborhoods
expected_neighbourhoods <- c("Downtown", "Scarborough", "North York", "Etobicoke", "East York")
test_neighbourhood_valid <- all(sim_data$NEIGHBOURHOOD_158 %in% expected_neighbourhoods)
print(paste("Test neighbourhood_158 is valid:", test_neighbourhood_valid))



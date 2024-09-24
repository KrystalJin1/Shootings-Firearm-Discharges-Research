#### Preamble ####
# Purpose: Downloads and saves the data from Toronto Open Data
# Author: Jin Zhang
# Date: 23 Septenmber 2024
# Contact: kry.zhang@utoronto.ca
# License: MIT
# Pre-requisites: None
# Any other information needed? None


#### Workspace setup ####
library(opendatatoronto)
library(tidyverse)
library(dplyr)

# get package
package <- show_package("4bc5511d-0ecf-487a-9214-7b2359ad8f61")
package

# get all resources for this package
resources <- list_package_resources("4bc5511d-0ecf-487a-9214-7b2359ad8f61")

# identify datastore resources; by default, Toronto Open Data sets datastore resource format to CSV for non-geospatial and GeoJSON for geospatial resources
datastore_resources <- filter(resources, 
                              tolower(format) %in% c('csv', 'geojson'))

# load the first datastore resource as a sample
download_data <- filter(datastore_resources, row_number()==1) %>% get_resource()
download_data

#### Save data ####
write_csv(download_data,"~/Desktop/Shootings-Firearm-Discharges-Research/data/raw_data/Shootings_data.csv") 
         

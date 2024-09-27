#### Preamble ####
# Purpose: Downloads and saves the TTC Subway Delay Data from Open Data Toronto
# Author: Arav Sri Agarwal
# Date: September 24, 2024
# Contact: Arav.Agarwal@mail.utoronto.ca
# Pre-requisites: Simulated and tested data
# Any other information needed? N/A

#### Workspace setup ####
library(opendatatoronto)
library(tidyverse)
library(dplyr)

#### Download data ####
# get package
package <- show_package("996cfe8d-fb35-40ce-b569-698d51fc683b")
package
### API above is for TTC Subway Delay Data, APIs below may be used in the future for 1. Bus Delay Data and 2. Streetcar Delay Data
### 1. "e271cdae-8788-4980-96ce-6a5c95bc6618" ; 2. "b68cb71b-44a7-4394-97e2-5d2f41462a5d"

# Get all resources for this package using the correct API
resources <- list_package_resources("996cfe8d-fb35-40ce-b569-698d51fc683b")

# Identify datastore resources
datastore_resources <- filter(resources, tolower(format) == 'xlsx')

# Assuming the first datastore resource is the relevant one
if (nrow(datastore_resources) > 0)
  data <- get_resource(datastore_resources$resource_id[1]) # Use the resource_id of the first resource
  
#### Save data ####
subway_delay_data <- filter(datastore_resources, name == "ttc-subway-delay-data") %>% get_resource()

write_csv(subway_delay_data, "data/raw_data/streetcar_delays2023.csv")
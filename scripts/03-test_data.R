#### Preamble ####
# Purpose: Sanity check of the data
# Author: Arav Sri Agarwal
# Date: September 24, 2024
# Contact: Arav.Agarwal@mail.utoronto.ca
# Pre-requisites: Simulated data
# Any other information needed? N/A

#### Workspace setup ####
library(tidyverse)

#### Load and test data ####
data <- read_csv("data/analysis_data/cleaned-ttc-subway-delay-data-2024.csv")

# Test for negative delay times
if (any(data$min_delay < 0)) {
  print("There are negative values in min_delay.")
} else {
  print("No negative values in min_delay - check passed.")
}

# Test for NAs in critical columns
critical_columns <- c("date", "time", "station", "min_delay")
na_check_results <- sapply(data[, critical_columns], function(x) any(is.na(x)))
if (any(na_check_results)) {
  print("NA values found in critical columns.")
} else {
  print("No NA values in critical columns - check passed.")
}

# Output the results of the NA check
print(na_check_results)

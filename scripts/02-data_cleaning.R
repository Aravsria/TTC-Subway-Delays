#### Preamble ####
# Purpose: Cleans the raw TTC Subway Delay data into an analysis-ready dataset
# Author: Arav Sri Agarwal
# Date: September 24, 2024
# Contact: Arav.Agarwal@mail.utoronto.ca
# Pre-requisites: Downloaded data
# Any other information needed? N/A

#### Workspace setup ####
library(tidyverse)  # For data manipulation and cleaning
library(readxl)     # For reading Excel files
library(lubridate)  # For handling date and time data
library(janitor)    # For cleaning column names

#### Load and clean data ####
# Load the raw data from an Excel file
raw_data <- read_excel("data/raw_data/ttc-subway-delay-data-2024.xlsx")

# Print the first few rows of the raw data to inspect its structure
print(head(raw_data))

# Clean the data
cleaned_data <- raw_data %>%
  clean_names() %>%  # Standardize column names for easier handling
  mutate(
    date = ymd(date),  # Convert date column to Date format, adjust function based on your date format
    time = hm(time)    # Adjusted to use hm() for "HH:MM" format
  ) %>%
  drop_na(min_delay) %>%  # Ensure there are no NA values in the min_delay column
  mutate(
    day_of_week = wday(date, label = TRUE, abbr = FALSE),  # Adds day of the week as a full textual representation
    hour_of_day = hour(time),  # Extract hour from time for hourly analysis
    is_weekend = day_of_week %in% c("Saturday", "Sunday")  # Identify weekend days
  ) %>%
  filter(min_delay >= 0)  # Assuming min_delay should not be negative

# Save the cleaned data to a new CSV for analysis
write_csv(cleaned_data, "data/analysis_data/cleaned-ttc-subway-delay-data-2024.csv")

# Output the structure of the cleaned data to verify
print(glimpse(cleaned_data))

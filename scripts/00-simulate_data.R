#### Preamble ####
# Purpose: Simulates data
# Author: Arav Sri Agarwal
# Date: September 24, 2024
# Contact: Arav.Agarwal@mail.utoronto.ca
# Pre-requisites: None
# Any other information needed? N/A

#### Workspace setup ####
library(tidyverse)
library(lubridate)

#### Simulate data ####
set.seed(304)

# Define the number of samples
n <- 1000

# Simulate Dates within the current year
dates <- seq(as.Date('2024-01-01'), as.Date('2024-12-31'), by="day")
simulated_dates <- sample(dates, n, replace = TRUE)

# Simulate Times across the day
simulated_times <- format(as.POSIXlt(runif(n, as.numeric(as.POSIXct('2024-01-01 00:00:00')),
                                           as.numeric(as.POSIXct('2024-01-02 00:00:00'))),
                                     origin="1970-01-01"), "%H:%M:%S")

# Vehicle Types
### Simulated Data is Based on 3 Different Data Sets from OpenDataToronto: 
### (TTC Subway (1), Bus (2), and Streetcar (3) Delay Data)
vehicle_types <- c("Bus", "Streetcar", "Subway")
simulated_vehicle_types <- sample(vehicle_types, n, replace = TRUE, prob = c(0.5, 0.3, 0.2))

# Simulate Route/Lines
routes <- paste("Route", sample(1:199, n, replace = TRUE))
simulated_routes <- sample(routes, n, replace = TRUE)

# Simulate Delay Reasons
delay_reasons <- c("Mechanical", "Operational", "Emergency", "Weather", "Security")
simulated_delay_reasons <- sample(delay_reasons, n, replace = TRUE, prob = c(0.3, 0.25, 0.15, 0.2, 0.1))

# Simulate Delay Duration in minutes
simulated_delay_durations <- sample(1:60, n, replace = TRUE)

# Combine all simulated data into a dataframe
simulated_data <- data.frame(Date = simulated_dates,
                             Time = simulated_times,
                             VehicleType = simulated_vehicle_types,
                             Route = simulated_routes,
                             Reason = simulated_delay_reasons,
                             DelayDuration = simulated_delay_durations)

# View the first few rows of the simulated data
head(simulated_data)

#### Write_csv
write.csv(simulated_data, file = "data/raw_data/simulated_ttc_delays.csv", row.names = FALSE)


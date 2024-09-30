#LDP Productivity & Reproducibility - Mini-project
#Author: David R. Zilkey (david.zilkey(at)mail.mcgill.ca)
#Last updated: Sept. 30, 2024


# Load required packages----
library(here)
library(tidyverse)

# Read in rawdata----

ice_data <- read_csv(here("00_rawdata", "ntl_icecover.csv"))

# Check and remove NA entries ----
ice_data %>% 
  filter(is.na(ice_duration) == T)

#There are 3 NA entires - two for lake Mendota, one for Lake Monona
#As these are right at the beginning of the time series - simplest to remove them

ice_data_clean <- ice_data %>% 
  drop_na()

write.csv(ice_data_clean, file.path(here("02_outdata"), "ice_data_clean.csv"), row.names = FALSE)



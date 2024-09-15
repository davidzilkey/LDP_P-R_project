#LDP Productivity & Reproducibility - Mini-project Check-in
#Author: David R. Zilkey (david.zilkey(at)mail.mcgill.ca)
#Last updated: Sept. 15, 2024

# Load and save raw data----
# Load required packages

library(lterdatasampler)
library(here)

# Load data from Long Term Ecological Research Program
data("ntl_icecover")

# Save ice cover data in a .csv for project use

write.csv(ntl_icecover, file.path(here("00_rawdata"), "ntl_icecover.csv"), row.names = FALSE)

          
#LDP Productivity & Reproducibility - Mini-project
#Author: David R. Zilkey (david.zilkey(at)mail.mcgill.ca)
#Last updated: Sept. 30, 2024

# Load required packages----
library(tidyverse)
library(ggplot2)
library(gridExtra)
library(mgcv)

#Set ggplot theme
theme_set(theme_bw())

#Import cleaned data from outdata
ice_data_clean <- read_csv(here("02_outdata", "ice_data_clean.csv"))

# Data visualization ----
#What do the trends in ice cover data look like?
ice_data_clean %>% 
  ggplot(aes(x = year, y = ice_duration)) +
  geom_path() +
  geom_point() +
  facet_wrap(vars(lakeid), nrow = 2)

#Could be linear or nonlinear, tough to tell.
  
# Modelling----
# Start with a linear model for each lake

mendota_lm <- gam(ice_duration ~ year, data = ice_data_clean %>% filter(lakeid == 'Lake Mendota'))
summary(mendota_lm)

# Explaining 22% of variability in ice cover duration

monona_lm <- gam(ice_duration ~ year, data = ice_data_clean %>% filter(lakeid == 'Lake Monona'))
summary(monona_lm)
#Explaining 26% of variability in ice cover duration

# Does a GAM fit better?
mendota_gam <- gam(ice_duration ~ s(year), data = ice_data_clean %>% filter(lakeid == 'Lake Mendota'))
summary(mendota_gam)
#Explaining 25% of variability

monona_gam <- gam(ice_duration ~ s(year), data = ice_data_clean %>% filter(lakeid == 'Lake Monona'))
summary(monona_gam)
#Explaining 26% of variability

#Are these better than LM's?
AIC(mendota_lm, mendota_gam)
AIC(monona_lm, monona_gam)

# Ever so slightly for Lake Mendota, not so for Lake Monona. For simplicity's sake, sticking with LMs.
rm(mendota_gam)
rm(monona_gam)



# Plotting----
#Create Fitted model output to bind with ice_data_clean
mendota_fitted <- as.data.frame(fitted(mendota_lm)) %>% 
  rename("fitted" = 'fitted(mendota_lm)') %>% 
  mutate(lakeid = 'Lake Mendota') %>% 
  bind_cols(ice_data_clean %>% filter(lakeid == 'Lake Mendota') %>% select(year))

monona_fitted <- as.data.frame(fitted(monona_lm)) %>% 
  rename("fitted" = 'fitted(monona_lm)') %>% 
  mutate(lakeid = 'Lake Monona') %>% 
  bind_cols(ice_data_clean %>% filter(lakeid == 'Lake Monona') %>% select(year))


ice_data_mendota <- ice_data_clean %>% 
  right_join(y = mendota_fitted, by = c('lakeid', 'year'))

ice_data_monona <- ice_data_clean %>% 
  right_join(y = monona_fitted, by = c('lakeid', 'year'))

ice_data_modelled <- bind_rows(ice_data_mendota, ice_data_monona)

rm(ice_data_mendota)
rm(ice_data_monona)

#Visualize linear models:
ice_data_modelled %>% 
  ggplot(aes(x = year, y = ice_duration)) +
  geom_path() +
  geom_point() +
  geom_line(aes(y = fitted), colour = "red", linewidth = 1.2) +
  facet_wrap(vars(lakeid), nrow = 2)

ggsave(here('03_figs', "modelled_ice_duration.png"))
  
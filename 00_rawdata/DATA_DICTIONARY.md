# DATA DICTIONARY

The data contained in this folder include the following .csv files:
- ntl_icecover.csv
  - North Temperate Lakes Ice Cover Data
  

## North Temperate Lakes Ice Cover Data

Data objects in this dataset include:
- Lakeid: the name of the lake for which the subsequent data is associated
- ice_on: the date (in YYYY-MM-DD) when ice was first observed on the lake
- ice_off: the date (in YYYY-MM-DD) when ice was last observed on the lake
- ice_duration: the number of days in which the lake was covered in ice
- year: the year (CE) when sampling commenced (i.e., the year of ice_on)

## Missing data

In some instances, an ice_on or ice_off year was not recorded and has a corresponding entry
of "NA". In this scenario, ice_duration will also be recorded "NA".

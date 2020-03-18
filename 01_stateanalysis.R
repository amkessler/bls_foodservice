# Data source: BLS Occupational Employment Statistics (2018) 
# https://www.bls.gov/oes/tables.htm


library(tidyverse)
library(janitor)
library(readxl)
library(writexl)


#import data for all states, all occupations
rawdata <- read_excel("raw_data/oesm18st/state_M2018_dl.xlsx")

#clean names
states_allrecs <- rawdata %>% 
  clean_names()


#cut down to only the measures we'll use here:

# -- tot_emp: Estimated total employment rounded to the nearest 10 (excludes self-employed)
# -- jobs_1000: The number of jobs (employment) in the given occupation per 1,000 jobs in the given area 
# -- h_mean: Mean hourly wage
# -- a_mean: Mean annual wage 
# -- annual: Contains "TRUE" if only the annual wages are released
# -- hourly:	Contains "TRUE" if only the hourly wages are released

states_allrecs <- states_allrecs %>% 
  select(
    area,
    st,
    state,
    occ_code,
    occ_title,
    occ_group,
    tot_emp,
    jobs_1000,
    h_mean,
    a_mean,
    annual,
    hourly
  )


glimpse(states_allrecs)

#format columns
states_allrecs <- states_allrecs %>% 
  mutate(
    tot_emp = as.numeric(tot_emp),
    jobs_1000 = as.numeric(jobs_1000),
    h_mean = as.numeric(h_mean),
    a_mean = as.numeric(a_mean)
  )






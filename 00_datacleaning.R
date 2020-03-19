# Data source: BLS Occupational Employment Statistics (2018) 
# https://www.bls.gov/oes/tables.htm

library(tidyverse)
library(janitor)
library(readxl)


#import data for all states, all occupations
rawstatesdata <- read_excel("raw_data/oesm18st/state_M2018_dl.xlsx")

#clean names
states_allrecs <- rawstatesdata %>% 
  clean_names()

#cut down to only the measures we'll use here:

# -- tot_emp: Estimated total employment rounded to the nearest 10 (excludes self-employed)
# -- jobs_1000: The number of jobs (employment) in the given occupation per 1,000 jobs in the given area 
# -- h_mean: Mean hourly wage
# -- a_mean: Mean annual wage 

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
    a_mean
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

#save for use in analysis steps
saveRDS(states_allrecs, "processed_data/states_allrecs.rds")



#-------------------------------------------------------------------------


##### Now the same thing but for the local MSA-level records #######

rawmsadata <- read_excel("raw_data/oesm18ma/MSA_M2018_dl.xlsx")

#clean names
msa_allrecs <- rawmsadata %>% 
  clean_names()

names(msa_allrecs)

#cut down to only the measures we'll use:
msa_allrecs <- msa_allrecs %>% 
  select(
    prim_state,
    area,
    area_name,
    occ_code,
    occ_title,
    occ_group,
    tot_emp,
    jobs_1000,
    h_mean,
    a_mean
  )

#format columns
msa_allrecs <- msa_allrecs %>% 
  mutate(
    tot_emp = as.numeric(tot_emp),
    jobs_1000 = as.numeric(jobs_1000),
    h_mean = as.numeric(h_mean),
    a_mean = as.numeric(a_mean)
  )

glimpse(msa_allrecs)

#save for use in analysis steps
saveRDS(msa_allrecs, "processed_data/msa_allrecs.rds")



##--------------------------------------------------------------

#### Bring in the national-level data #####

rawnationaldata <- read_excel("raw_data/oesm18nat/national_M2018_dl.xlsx")

#clean names
national_allrecs <- rawnationaldata %>% 
  clean_names()

names(national_allrecs)

#cut down to only the measures we'll use:
national_allrecs <- national_allrecs %>% 
  mutate(
    data_scope = "national"
  ) %>% 
  select(
    data_scope,
    occ_code,
    occ_title,
    occ_group,
    tot_emp,
    h_mean,
    a_mean
  ) 

#format columns
national_allrecs <- national_allrecs %>% 
  mutate(
    tot_emp = as.numeric(tot_emp),
    h_mean = as.numeric(h_mean),
    a_mean = as.numeric(a_mean)
  )

glimpse(national_allrecs)

#save for use in analysis steps
saveRDS(national_allrecs, "processed_data/national_allrecs.rds")

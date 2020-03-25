
library(tidyverse)
library(janitor)
library(readxl)
library(writexl)


#load saved processed data files from step 00
states_allrecs <- readRDS("processed_data/states_allrecs.rds")
msa_allrecs <- readRDS("processed_data/msa_allrecs.rds")
national_allrecs <- readRDS("processed_data/national_allrecs.rds")


#limit to just the 50 states and DC
states_allrecs <- states_allrecs %>% 
  filter(!st %in% c("GU", "VI", "PR"))

msa_allrecs <- msa_allrecs %>% 
  filter(!prim_state %in% c("GU", "VI", "PR"))



# waiters
state_waiters <- state_foodserv_all %>% 
  filter(occ_code == "35-3031")  %>% 
  select(state, occ_title, jobs_1000)

# bartenders
state_bartenders <- state_foodserv_all %>% 
  filter(occ_code == "35-3011") %>% 
  select(state, occ_title, jobs_1000)

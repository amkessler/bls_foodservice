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


#pull together data for just waiter/waitresses and bartenders ####

state_wait_bart <- states_allrecs %>% 
  filter(occ_code %in% c("35-3031", "35-3011")) %>% 
  select(state, occ_title, jobs_1000)

#sum to get total combined per 1000 figures
combjob100_state_wait_bart <- state_wait_bart %>% 
  group_by(state) %>% 
  summarise(jobs_1000_combined = sum(jobs_1000)) %>% 
  arrange(desc(jobs_1000_combined))

combjob100_state_wait_bart



## now we'll do it for MSAs ####

msa_wait_bart <- msa_allrecs %>% 
  filter(occ_code %in% c("35-3031", "35-3011")) %>% 
  select(area_name, occ_title, jobs_1000)

#sum to get total combined per 1000 figures
combjob100_msa_wait_bart <- msa_wait_bart %>% 
  group_by(area_name) %>% 
  summarise(jobs_1000_combined = sum(jobs_1000)) %>% 
  arrange(desc(jobs_1000_combined))

combjob100_msa_wait_bart


#save to Excel for sharing
sheets <- list("by STATE" = combjob100_state_wait_bart,
               "by MSA" = combjob100_msa_wait_bart)

write_xlsx(sheets, "output/wait_bart_combined.xlsx")

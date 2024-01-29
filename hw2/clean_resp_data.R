# Week 2 assignment 
# Cleans RESP-NET data 
# Saves clean version of file as .RDS file

library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)

respTable <- read_csv("data/Rates_of_Laboratory-Confirmed_RSV__COVID-19__and_Flu_Hospitalizations_from_the_RESP-NET_Surveillance_Systems_20240115.csv")

problems(respTable)
summary(respTable)


print(ggplot(respTable, aes(x=`Weekly Rate`))
      + geom_histogram()
)

print(ggplot(respTable, aes(x=`Cumulative Rate`))
      + geom_histogram()
      )

# respTableClean <- ( respTable 
#                     %>% filter(!is.na(`Weekly Rate`),
#                                !is.na(`Cumulative Rate`),
#                                !is.na(Sex),
#                                !is.na(`Race/Ethnicity`))
# )

# taking BMB's suggestions from below!
respTableClean <- ( respTable 
                   |> drop_na() # drop all missing data 
                   |> rename(Network = 'Surveillance Network',
                             MMWRyear = 'MMWR Year',
                             MMWRweek = 'MMWR Week',
                             ageGroup = 'Age group',
                             Race = 'Race/Ethnicity',
                             weeklyRate = 'Weekly Rate', 
                             cumulativeRate = 'Cumulative Rate',
                             endingDate = 'Week Ending Date') # renaming variables to easier-to-type names
                   |> mutate(across(where(is.character), factor)) # changing character vectors to factors
                   |> filter(ageGroup ==  '0-4 years' 
                             | ageGroup == '5-17 years'
                             | ageGroup == '18-49 years'
                             | ageGroup == '50-64 years'
                             | ageGroup == '65+ years' 
                             | ageGroup == 'Overall') # getting rid of age group redundancies
)

summary(respTableClean)
  

## BMB: you could also use respTable %>% tidyr::drop_na() for this
## * I often use this cleaning step to change variable names to computer-friendly
## ones (e.g. in particular no spaces), via dplyr::rename()
## * You should also consider changing character vectors to factors,
## with sensible orderings (to do it by brute force, you can use
## mutate(across(where(is.character), factor))
## * you should consider creating a date variable from your Season and week variables (if you ever want to plot a long time series)

saveRDS(respTableClean, file="hw2/tmp/respTableClean.rds")

## mark: 2
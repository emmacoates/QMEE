# Week 2 assignment 
# Cleans RESP-NET data 
# Saves clean version of file as .RDS file

library(tidyverse)
library(readr)
library(dplyr)

respTable <- read_csv("Rates_of_Laboratory-Confirmed_RSV__COVID-19__and_Flu_Hospitalizations_from_the_RESP-NET_Surveillance_Systems_20240115.csv")

problems(respTable)
summary(respTable)


print(ggplot(respTable, aes(x=`Weekly Rate`))
      + geom_histogram()
)

print(ggplot(respTable, aes(x=`Cumulative Rate`))
      + geom_histogram()
      )

respTableClean <- ( respTable 
                    %>% filter(!is.na(`Weekly Rate`),
                               !is.na(`Cumulative Rate`),
                               !is.na(Sex),
                               !is.na(`Race/Ethnicity`))
)

## BMB: you could also use respTable %>% tidyr::drop_na() for this
## * I often use this cleaning step to change variable names to computer-friendly
## ones (e.g. in particular no spaces), via dplyr::rename()
## * You should also consider changing character vectors to factors,
## with sensible orderings (to do it by brute force, you can use
## mutate(across(where(is.character), factor))
## * you should consider creating a date variable from your Season and week variables (if you ever want to plot a long time series)

saveRDS(respTableClean, "respTableClean.rds")

## mark: 2

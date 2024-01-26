# Week 2 assignment 
# Cleans RESP-NET data 
# Saves clean version of file as .RDS file

library(readr)
library(dplyr)
library(tidyr)

respTable <- read_csv("data/Rates_of_Laboratory-Confirmed_RSV__COVID-19__and_Flu_Hospitalizations_from_the_RESP-NET_Surveillance_Systems_20240115.csv")

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

saveRDS(respTableClean, file="hw2/tmp/respTableClean.rds")

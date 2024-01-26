# Week 3 assignment 
# Visualizes cleaned data from hw2

library(readr)
library(dplyr)
library(tidyr)
library(ggplot2); theme_set(theme_bw(base_size = 14)) 

dat <- readRDS("hw2/tmp/respTableClean.rds")

base <- (ggplot(dat 
                |> filter(ageGroup == 'Overall', 
                          Sex == 'Overall',
                          Race == 'Overall',
                          Network != 'Combined'))
         + aes(x=endingDate, y=weeklyRate, color=Network)
         + geom_line()
)

print(base)
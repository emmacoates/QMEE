# Week 1 assignment 
# Calculating mean rate of infection for each flu/RSV/COVID for each year 

library(tidyverse)

resp_dd <- read.csv("data/Rates_of_Laboratory-Confirmed_RSV__COVID-19__and_Flu_Hospitalizations_from_the_RESP-NET_Surveillance_Systems_20240115.csv")

# Extracts data combined from all genders, races/ethnicities, age groups, and 
# geographical locations given a specified year and disease monitoring network 
# (i.e., FluSurv-NET, RSV-NET, COVID-NET)
#
# INPUT 
# disease_net = specified disease network (input as str)
# year = year disease data collected (input as str)
#
# OUTPUT
# a data frame of combined data for specified year and disease monitoring network
get_overall_yearly_dd <- function( disease_net, year ) {

    ( resp_dd 
    %>% filter( Surveillance.Network == disease_net, 
                MMWR.Year == year,
                Age.group == 'Overall', 
                Sex == 'Overall', 
                Race.Ethnicity == 'Overall', 
                Site == 'Overall' ) )
  
}

# extracting combined data from flu for each year into separate data frames 
# & calculating mean overall rate for each year for flu 
mean_rate_flu2018 <- mean(get_overall_yearly_dd('FluSurv-NET', '2018')$Weekly.Rate)
mean_rate_flu2019 <- mean(get_overall_yearly_dd('FluSurv-NET', '2019')$Weekly.Rate)
mean_rate_flu2020 <- mean(get_overall_yearly_dd('FluSurv-NET', '2020')$Weekly.Rate)
mean_rate_flu2021 <- mean(get_overall_yearly_dd('FluSurv-NET', '2021')$Weekly.Rate)
mean_rate_flu2022 <- mean(get_overall_yearly_dd('FluSurv-NET', '2022')$Weekly.Rate)
mean_rate_flu2023 <- mean(get_overall_yearly_dd('FluSurv-NET', '2023')$Weekly.Rate)
mean_rate_flu_yearly <- c(mean_rate_flu2018, mean_rate_flu2019, mean_rate_flu2020, 
                          mean_rate_flu2021, mean_rate_flu2022, mean_rate_flu2023)

# extracting combined data from RSV for each year into separate data frames 
# & calculating mean overall rate for each year for RSV
mean_rate_RSV2018 <- mean(get_overall_yearly_dd('RSV-NET', '2018')$Weekly.Rate)
mean_rate_RSV2019 <- mean(get_overall_yearly_dd('RSV-NET', '2019')$Weekly.Rate)
mean_rate_RSV2020 <- mean(get_overall_yearly_dd('RSV-NET', '2020')$Weekly.Rate)
mean_rate_RSV2021 <- mean(get_overall_yearly_dd('RSV-NET', '2021')$Weekly.Rate)
mean_rate_RSV2022 <- mean(get_overall_yearly_dd('RSV-NET', '2022')$Weekly.Rate)
mean_rate_RSV2023 <- mean(get_overall_yearly_dd('RSV-NET', '2023')$Weekly.Rate)
mean_rate_RSV_yearly <- c(mean_rate_RSV2018, mean_rate_RSV2019, mean_rate_RSV2020, 
                          mean_rate_RSV2021, mean_rate_RSV2022, mean_rate_RSV2023)

# extracting combined data from COVID for each year into separate data frames 
# & calculating mean overall rate for each year for COVID
mean_rate_COVID2020 <- mean(get_overall_yearly_dd('COVID-NET', '2020')$Weekly.Rate)
mean_rate_COVID2021 <- mean(get_overall_yearly_dd('COVID-NET', '2021')$Weekly.Rate)
mean_rate_COVID2022 <- mean(get_overall_yearly_dd('COVID-NET', '2022')$Weekly.Rate)
mean_rate_COVID2023 <- mean(get_overall_yearly_dd('COVID-NET', '2023')$Weekly.Rate)
mean_rate_COVID_yearly <- c(NA, NA, mean_rate_COVID2020, mean_rate_COVID2021, 
                            mean_rate_COVID2022, mean_rate_COVID2023)

plot(2018:2023, type='b', mean_rate_flu_yearly, col='blue', ylim=c(0,9), xlab='Year', ylab='Mean rate of infection')
points(2018:2023, type='b', mean_rate_COVID_yearly, col='red')
points(2018:2023, type='b', mean_rate_RSV_yearly, col='purple')
legend('topleft', legend=c('flu', 'COVID', 'RSV'), col=c('blue', 'red', 'purple'), lty=1)
title('Mean rate of infection per year: flu, RSV, COVID')


# Week 1 assignment 
# Calculating mean rate of infection for each flu/RSV/COVID for each year 

resp_data <- read.csv("Rates_of_Laboratory-Confirmed_RSV__COVID-19__and_Flu_Hospitalizations_from_the_RESP-NET_Surveillance_Systems_20240115.csv")

# extracting combined data from flu for each year into separate data frames 
overall2018_flu <- resp_data[which(resp_data$Surveillance.Network == 'FluSurv-NET' & 
                        resp_data$MMWR.Year == '2018' & resp_data$Age.group == 'Overall' & 
                        resp_data$Sex == 'Overall' & resp_data$Race.Ethnicity == 'Overall' & 
                        resp_data$Site == 'Overall'),]
overall2019_flu <- resp_data[which(resp_data$Surveillance.Network == 'FluSurv-NET' & 
                                      resp_data$MMWR.Year == '2019' & resp_data$Age.group == 'Overall' & 
                                      resp_data$Sex == 'Overall' & resp_data$Race.Ethnicity == 'Overall' & 
                                      resp_data$Site == 'Overall'),]
overall2020_flu <- resp_data[which(resp_data$Surveillance.Network == 'FluSurv-NET' & 
                                      resp_data$MMWR.Year == '2020' & resp_data$Age.group == 'Overall' & 
                                      resp_data$Sex == 'Overall' & resp_data$Race.Ethnicity == 'Overall' & 
                                      resp_data$Site == 'Overall'),]
overall2021_flu <- resp_data[which(resp_data$Surveillance.Network == 'FluSurv-NET' & 
                                      resp_data$MMWR.Year == '2021' & resp_data$Age.group == 'Overall' & 
                                      resp_data$Sex == 'Overall' & resp_data$Race.Ethnicity == 'Overall' & 
                                      resp_data$Site == 'Overall'),]
overall2022_flu <- resp_data[which(resp_data$Surveillance.Network == 'FluSurv-NET' & 
                                      resp_data$MMWR.Year == '2022' & resp_data$Age.group == 'Overall' & 
                                      resp_data$Sex == 'Overall' & resp_data$Race.Ethnicity == 'Overall' & 
                                      resp_data$Site == 'Overall'),]
overall2023_flu <- resp_data[which(resp_data$Surveillance.Network == 'FluSurv-NET' & 
                                      resp_data$MMWR.Year == '2023' & resp_data$Age.group == 'Overall' & 
                                      resp_data$Sex == 'Overall' & resp_data$Race.Ethnicity == 'Overall' & 
                                      resp_data$Site == 'Overall'),]

# extracting combined data from RSV for each year into separate data frames 
overall2018_RSV <- resp_data[which(resp_data$Surveillance.Network == 'RSV-NET' & 
                                     resp_data$MMWR.Year == '2018' & resp_data$Age.group == 'Overall' & 
                                     resp_data$Sex == 'Overall' & resp_data$Race.Ethnicity == 'Overall' & 
                                     resp_data$Site == 'Overall'),]
overall2019_RSV <- resp_data[which(resp_data$Surveillance.Network == 'RSV-NET' & 
                                     resp_data$MMWR.Year == '2019' & resp_data$Age.group == 'Overall' & 
                                     resp_data$Sex == 'Overall' & resp_data$Race.Ethnicity == 'Overall' & 
                                     resp_data$Site == 'Overall'),]
overall2020_RSV <- resp_data[which(resp_data$Surveillance.Network == 'RSV-NET' & 
                                     resp_data$MMWR.Year == '2020' & resp_data$Age.group == 'Overall' & 
                                     resp_data$Sex == 'Overall' & resp_data$Race.Ethnicity == 'Overall' & 
                                     resp_data$Site == 'Overall'),]
overall2021_RSV <- resp_data[which(resp_data$Surveillance.Network == 'RSV-NET' & 
                                     resp_data$MMWR.Year == '2021' & resp_data$Age.group == 'Overall' & 
                                     resp_data$Sex == 'Overall' & resp_data$Race.Ethnicity == 'Overall' & 
                                     resp_data$Site == 'Overall'),]
overall2022_RSV <- resp_data[which(resp_data$Surveillance.Network == 'RSV-NET' & 
                                     resp_data$MMWR.Year == '2022' & resp_data$Age.group == 'Overall' & 
                                     resp_data$Sex == 'Overall' & resp_data$Race.Ethnicity == 'Overall' & 
                                     resp_data$Site == 'Overall'),]
overall2023_RSV <- resp_data[which(resp_data$Surveillance.Network == 'RSV-NET' & 
                                     resp_data$MMWR.Year == '2023' & resp_data$Age.group == 'Overall' & 
                                     resp_data$Sex == 'Overall' & resp_data$Race.Ethnicity == 'Overall' & 
                                     resp_data$Site == 'Overall'),]

# extracting combined data from COVID for each year into separate data frames 
overall2018_COVID <- resp_data[which(resp_data$Surveillance.Network == 'COVID-NET' & 
                                     resp_data$MMWR.Year == '2018' & resp_data$Age.group == 'Overall' & 
                                     resp_data$Sex == 'Overall' & resp_data$Race.Ethnicity == 'Overall' & 
                                     resp_data$Site == 'Overall'),]
overall2019_COVID <- resp_data[which(resp_data$Surveillance.Network == 'COVID-NET' & 
                                     resp_data$MMWR.Year == '2019' & resp_data$Age.group == 'Overall' & 
                                     resp_data$Sex == 'Overall' & resp_data$Race.Ethnicity == 'Overall' & 
                                     resp_data$Site == 'Overall'),]
overall2020_COVID <- resp_data[which(resp_data$Surveillance.Network == 'COVID-NET' & 
                                     resp_data$MMWR.Year == '2020' & resp_data$Age.group == 'Overall' & 
                                     resp_data$Sex == 'Overall' & resp_data$Race.Ethnicity == 'Overall' & 
                                     resp_data$Site == 'Overall'),]
overall2021_COVID <- resp_data[which(resp_data$Surveillance.Network == 'COVID-NET' & 
                                     resp_data$MMWR.Year == '2021' & resp_data$Age.group == 'Overall' & 
                                     resp_data$Sex == 'Overall' & resp_data$Race.Ethnicity == 'Overall' & 
                                     resp_data$Site == 'Overall'),]
overall2022_COVID <- resp_data[which(resp_data$Surveillance.Network == 'COVID-NET' & 
                                     resp_data$MMWR.Year == '2022' & resp_data$Age.group == 'Overall' & 
                                     resp_data$Sex == 'Overall' & resp_data$Race.Ethnicity == 'Overall' & 
                                     resp_data$Site == 'Overall'),]
overall2023_COVID <- resp_data[which(resp_data$Surveillance.Network == 'COVID-NET' & 
                                     resp_data$MMWR.Year == '2023' & resp_data$Age.group == 'Overall' & 
                                     resp_data$Sex == 'Overall' & resp_data$Race.Ethnicity == 'Overall' & 
                                     resp_data$Site == 'Overall'),]

# calculating mean overall rate for each year for flu 
mean_rate_flu2018 <- sum(overall2018_flu$Weekly.Rate)/length(overall2018_flu$Weekly.Rate)
mean_rate_flu2019 <- sum(overall2019_flu$Weekly.Rate)/length(overall2019_flu$Weekly.Rate)
mean_rate_flu2020 <- sum(overall2020_flu$Weekly.Rate)/length(overall2020_flu$Weekly.Rate)
mean_rate_flu2021 <- sum(overall2021_flu$Weekly.Rate)/length(overall2021_flu$Weekly.Rate)
mean_rate_flu2022 <- sum(overall2022_flu$Weekly.Rate)/length(overall2022_flu$Weekly.Rate)
mean_rate_flu2023 <- sum(overall2023_flu$Weekly.Rate)/length(overall2023_flu$Weekly.Rate)
mean_rate_flu_yearly <- c(mean_rate_flu2018, mean_rate_flu2019, mean_rate_flu2020, 
                          mean_rate_flu2021, mean_rate_flu2022, mean_rate_flu2023)

# calculating mean overall rate for each year for RSV
mean_rate_RSV2018 <- sum(overall2018_RSV$Weekly.Rate)/length(overall2018_RSV$Weekly.Rate)
mean_rate_RSV2019 <- sum(overall2019_RSV$Weekly.Rate)/length(overall2019_RSV$Weekly.Rate)
mean_rate_RSV2020 <- sum(overall2020_RSV$Weekly.Rate)/length(overall2020_RSV$Weekly.Rate)
mean_rate_RSV2021 <- sum(overall2021_RSV$Weekly.Rate)/length(overall2021_RSV$Weekly.Rate)
mean_rate_RSV2022 <- sum(overall2022_RSV$Weekly.Rate)/length(overall2022_RSV$Weekly.Rate)
mean_rate_RSV2023 <- sum(overall2023_RSV$Weekly.Rate)/length(overall2023_RSV$Weekly.Rate)
mean_rate_RSV_yearly <- c(mean_rate_RSV2018, mean_rate_RSV2019, mean_rate_RSV2020, 
                          mean_rate_RSV2021, mean_rate_RSV2022, mean_rate_RSV2023)

# calculating mean overall rate for each year for COVID 
mean_rate_COVID2018 <- sum(overall2018_COVID$Weekly.Rate)/length(overall2018_COVID$Weekly.Rate)
mean_rate_COVID2019 <- sum(overall2019_COVID$Weekly.Rate)/length(overall2019_COVID$Weekly.Rate)
mean_rate_COVID2020 <- sum(overall2020_COVID$Weekly.Rate)/length(overall2020_COVID$Weekly.Rate)
mean_rate_COVID2021 <- sum(overall2021_COVID$Weekly.Rate)/length(overall2021_COVID$Weekly.Rate)
mean_rate_COVID2022 <- sum(overall2022_COVID$Weekly.Rate)/length(overall2022_COVID$Weekly.Rate)
mean_rate_COVID2023 <- sum(overall2023_COVID$Weekly.Rate)/length(overall2023_COVID$Weekly.Rate)
mean_rate_COVID_yearly <- c(mean_rate_COVID2018, mean_rate_COVID2019, mean_rate_COVID2020, 
                          mean_rate_COVID2021, mean_rate_COVID2022, mean_rate_COVID2023)

plot(2018:2023, type='b', mean_rate_flu_yearly, col='blue', ylim=c(0,9), xlab='Year', ylab='Mean rate of infection')
points(2018:2023, type='b', mean_rate_COVID_yearly, col='red')
points(2018:2023, type='b', mean_rate_RSV_yearly, col='purple')
legend('topleft', legend=c('flu', 'RSV', 'COVID'), col=c('blue', 'red', 'purple'), lty=1)
title('Mean rate of infection per year: flu, RSV, COVID')


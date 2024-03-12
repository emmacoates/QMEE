## Week 7 assignment 
## Creates diagnostic plots + inferential plots for GLM

# Dependencies -----------------------------------------------------------------------------------------------
library(readr)
library(dplyr)
library(splines)
library(performance)
library(ggplot2)

# Data -------------------------------------------------------------------------------------------------------
dat <- readRDS("hw2/tmp/respTableClean.rds") ## load cleaned data

covidDat <- ( dat
              |> filter(Network == 'COVID-NET', 
                        Race == 'Overall',
                        Sex == 'Overall',
                        Site == 'Overall', 
                        ageGroup != 'Overall')
) ## only take Covid data + age group data 

plot(covidDat$endingDate, covidDat$weeklyRate) ## look at dot plot of data 

# Models ----------------------------------------------------------------------------------------------------

covidDatSeason <- split(covidDat, f = covidDat$Season)
mCovid <- glm( formula = weeklyRate ~ ns(endingDate, df=5)*ageGroup,
              data = covidDat, family=quasipoisson(link="log"))
mCovidVec <- lapply( covidDatSeason[2:6], function(x) update(mCovid, data = x) )
lapply( mCovidVec, function(x) check_model(x) )
lapply( mCovidVec, function(x) summary(x) )
## residual deviance / df << 1 for most models and > 1.2 for one model (2021-2022 season)
## I am not sure what other family to use for this data/if something in the way I am using age group as 
## a predictor needs to change? 

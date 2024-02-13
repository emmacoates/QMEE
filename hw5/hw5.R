## Week 5 assignment 
## Creates diagnostic plots + inferential plots 

## H0: beta_5 > 0 (i.e., coefficient for age group 65+ years has a positive effect on Covid hospitalization weekly rates) 

# Dependencies -----------------------------------------------------------------------------------------------
library(readr)
library(dplyr)
library(tidyr)
library(splines)
library(performance)
library(mgcv)
library(dotwhisker)

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

## -- separate models out by season (i.e., one season is 2019-20, next is 2020-21)
## -- choose lm for models w/ predictors of week in the season + age group -- I am assuming
##      age group would not be enough alone to get an good model for time series data 
## -- I think ARIMA would be a better model for time series data, but I am unsure/confused how 
##      to include age as a predictor in an ARIMA model since it would be a categorical predictor 
##      and not continuous -- I also wasn't sure if ARIMA/GAM models are considered linear models/
##      if generalized linear models/generalized additive models are considered linear models,
##      so for this assignment, I chose lm. 

## 2019-20 --------------------------------------------------------------------------------------------------
mCovid2020 <- lm( formula = weeklyRate ~ ns(MMWRweek) + ageGroup,
                   data = ( covidDat |> filter(Season == '2019-20') ) )
check_model(mCovid2020) ## diagnostic plots
dwplot(mCovid2020, by_2sd = T) ## coefficient plot 

## 2020-21 --------------------------------------------------------------------------------------------------
mCovid2021 <- lm( formula = weeklyRate ~ ns(MMWRweek) + ageGroup,
                   data = ( covidDat |> filter(Season == '2020-21') ) )
check_model(mCovid2021) ## diagnostic plots
dwplot(mCovid2021, by_2sd = T) ## coefficient plot 

## 2021-22 --------------------------------------------------------------------------------------------------
mCovid2022 <- lm( formula = weeklyRate ~ ns(MMWRweek) + ageGroup, 
                   data = ( covidDat |> filter(Season == '2021-22') ) )
check_model(mCovid2022) ## diagnostic plots
dwplot(mCovid2022, by_2sd = T) ## coefficient plot 

## 2022-23 --------------------------------------------------------------------------------------------------
mCovid2023 <- lm( formula = weeklyRate ~ ns(MMWRweek) + ageGroup, 
                   data = ( covidDat |> filter(Season == '2022-23') ) )
check_model(mCovid2023) ## diagnostic plots
dwplot(mCovid2023, by_2sd = T) ## coefficient plot 

## The coefficients plots support the prediction the age group 65+ years has a higher rates of hospitalization, 
## but I would not use these models to predict this -- the diagnostic plots show the models not fitting the data well. 




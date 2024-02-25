## Week 5 assignment 
## Creates diagnostic plots + inferential plots 

## BMB: this would probably be your *alternative* hypothesis (H0 usually stands for "null hypothesis")
## H0: beta_5 > 0 (i.e., coefficient for age group 65+ years has a positive effect on Covid hospitalization weekly rates) 

# Dependencies -----------------------------------------------------------------------------------------------
library(readr)
library(dplyr)
library(splines)
library(performance)
library(dotwhisker)
## BMB: I don't see where you use these packages?
library(mgcv)
library(tidyr)


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


## BMB I would use update() for these models, and possibly the subset argument instead of filter().
##  Also consider using split() and lapply(), or `lme4::lmList()`

## BMB: if you call ns() with no X it just scales the variable - it doesn't create a spline basis at all.
## so this is probably not what you meant what to do ...
## you should probably specify a df= argument ... (or talk to us about using mgcv::gam() to fit *penalized* splines
X <- model.matrix( ~ 0 + ns(MMWRweek) + MMWRweek, data = filter(covidDat, Season == "2019-20"))
head(X)
plot(X[,1], X[,2])

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

## There are several things you should probably consider to improve these models; the main one is to improve your splines,
## as discussed above. You might also want to consider allowing the seasonal patterns to differ by age group,
## which would be an interaction between ns() and ageGroup (e.g. ns(MMWRweek, df=5)*ageGroup). Also, consider treating
## ageGroup as an *ordered factor*, which will give you a confusing but possibly useful parameterization e.g. see here:
## https://stats.stackexchange.com/questions/253429/glm-interpretation-of-parameters-of-ordinal-predictor-variables
## You could also consider *successive differences** contrasts.

## It would be useful to create a *combined* coefficient plot (pass a list() to dwplot), to look at the differences in
## age effects across seasons, or even to create a single regression model with all seasons in it (and season as a predictor
## variable interacting with other terms) so you can make inferences about differences in age patterns across seasons ...

## mark: 2

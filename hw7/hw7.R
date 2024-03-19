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

# Models --------------------------------------------------------------

covidDatSeason <- split(covidDat, f = covidDat$Season)
mCovid <- glm( formula = weeklyRate ~ ns(endingDate, df=5)*ageGroup,
              data = covidDat, family=quasipoisson(link="log"))
## BMB: nice
mCovidVec <- lapply( covidDatSeason[2:6], function(x) update(mCovid, data = x) )
lapply( mCovidVec, function(x) check_model(x) )
lapply( mCovidVec, function(x) summary(x) )
## residual deviance / df << 1 for most models and > 1.2 for one model (2021-2022 season)

## BMB: if you're already using quasipoisson you don't need to check overdispersion, it's already accounted for (I think "worrying about overdispersion when you don't have to" was in my list of GLM goofs ... ?

## I am not sure what other family to use for this data/if something in the way I am using age group as 
## a predictor needs to change?

## BMB: I'm just going to look at one year
check_model(mCovidVec[[1]])
summary(mCovidVec[[1]])


dd <- (data.frame(covidDatSeason[[2]],
                  pred = predict(mCovidVec[[1]], type = "response"))
    |> select(endingDate, ageGroup, weeklyRate, pred)
    |> tidyr::pivot_longer(c("pred", "weeklyRate"), names_to = "var")
)
library(ggplot2); theme_set(theme_bw())
gg0 <- ggplot(dd, aes(endingDate, value)) +
    geom_line(aes(colour = ageGroup, linetype = var))

print(gg0)
print(gg0 + scale_y_log10())

## endingDate is causing problems, use MMWRweek instead ...
library(sjPlot)
m2 <- update(mCovidVec[[1]], . ~ ns(MMWRweek, df=5)*ageGroup,
             data = covidDatSeason[[2]])
gg1 <- plot_model(m2, type = "pred", terms = c("MMWRweek", "ageGroup"),
           show.data = TRUE)

print(gg1)
print(gg1 + scale_y_log10() + coord_cartesian(ylim=c(1e-2, NA)))

## BMB: where are the inferential plots? Interpretation? Did I miss something?
## (Inferential plots are admittedly hard for spline models,
##  where the parameters aren't really meaningful, but a prediction
## plot (as above) might be OK

## mark: 1.9

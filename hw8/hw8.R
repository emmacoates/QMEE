## Week 8 assignment 
## Creates diagnostic plots + inferential plots (Bayesian model)

# Dependencies -----------------------------------------------------------------------------------------------
library(dplyr)
library(broom.mixed)
library(R2jags)
library(emdbook)
library(lattice)
library(ggplot2)

## utility for constructing an automatically named list
named_list <- lme4:::namedList



# Data -------------------------------------------------------------------------------------------------------
dat <- readRDS("hw2/tmp/respTableClean.rds") ## load cleaned data

covidDat <- ( dat
              |> filter(Network == 'COVID-NET', 
                        Race == 'Overall',
                        Sex == 'Overall',
                        Site == 'Overall', 
                        ageGroup != 'Overall')
) ## only take Covid data + age group data 

## Model fit 1 (time as predictor) -----------------------------------------------------------------------
## create list of data
covidDat1 <- with( covidDat,
                   named_list(N=nrow(covidDat),            ## total obs
                              time=as.numeric(endingDate),
                              rate=weeklyRate) )

# frequentist lm model 
summary(lm(weeklyRate~endingDate, data=covidDat))

# diy JAGS model
jagsmodel1 <- function() {
  for (i in 1:N){
    rate[i] ~ dnorm(pred[i],tau)
    pred[i] <- m_time*time[i] 
  }
  m_time ~ dnorm(0, .0001)
  tau ~ dgamma(.001, .001)
}

jags.fit1 <- jags(model.file=jagsmodel1,
                 parameters=c("m_time"),
                 data = covidDat1,
                 n.chains = 4,
                 inits=NULL)

bb1 <- jags.fit1$BUGSoutput  ## extract the "BUGS output" component
mm1 <- as.mcmc.bugs(bb1)  ## convert it to an "mcmc" object that coda can handle
plot(jags.fit1)             ## large-format graph
xyplot(mm1,layout=c(2,3))  ## prettier trace plot
densityplot(mm1,layout=c(2,3)) ## prettier density plot
gg_jags1 <- ggplot(tidy(jags.fit1, conf.int = TRUE), aes(estimate, term, xmin = conf.low, xmax = conf.high)) + geom_pointrange()
print(gg_jags1)


## Model fit 2 (age as predictor) ------------------------------------------------------------------------
# frequentist lm model 
summary(lm(weeklyRate~ageGroup, data=covidDat))

## create list of data
covidDat2 <- with( covidDat,
                   named_list(N=nrow(covidDat),            ## total obs
                              age=as.numeric(ageGroup),
                              nage=length(levels(ageGroup)),
                              rate=weeklyRate) )
jagsmodel2 <- function() {
  for (i in 1:N) {
    ## Poisson model
    logmean[i] <- m_age[age[i]]    ## predicted log(counts)
    pred[i] <- exp(logmean[i])       ## predicted counts
    ## use log-link so that we never end up with negative predicted values
    rate[i] ~ dnorm(pred[i], tau)
  }
  ## define priors for all parameters in a loop
  for (i in 1:nage) {
    m_age[i] ~ dnorm(0,0.001)
  }
  
  tau ~ dgamma(.001, .001)
}

jags.fit2 <- jags(model.file=jagsmodel2,
                  parameters=c("m_age"),
                  data = covidDat2,
                  inits=NULL)

bb2 <- jags.fit2$BUGSoutput  ## extract the "BUGS output" component
mm2 <- as.mcmc.bugs(bb2)  ## convert it to an "mcmc" object that coda can handle
plot(jags.fit2)             ## large-format graph
xyplot(mm2,layout=c(2,3))  ## prettier trace plot
densityplot(mm2,layout=c(2,3)) ## prettier density plot
gg_jags2 <- ggplot(tidy(jags.fit2, conf.int = TRUE), aes(estimate, term, xmin = conf.low, xmax = conf.high)) + geom_pointrange()
print(gg_jags2)



## Models that throw errors/don't compile -------------------------------------------------------------------------
## I tried creating an additive model that takes into account both the date & age group,
##   but I could not get the model to compile -- the code for this is below!
## create list of data
# covidDat1 <- with( covidDat,
#                 named_list(N=nrow(covidDat),            ## total obs
#                            nage=length(levels(Age)), ## number of categories
#                            season=as.numeric(Season),  
#                            age=as.numeric(ageGroup),     ## numeric index 
#                            rate=weeklyRate) )
# 
# # Models ----------------------------------------------------------------------------------------------------
# 
# ## for light, we're going to use a trick that works well
# ## when we only have two levels of a factor: use as.numeric(f)-1,
# ## which equals 0 (don't add anything) for the first level of
# ## the factor and 1 (add the specified coefficient) for the second
# ## level of the factor
# ## additive model (light and time)
# agetimemodel <- function() {
#   for (i in 1:N) {
#     ## Poisson model
#     logmean0[i] <- b_season[season[i]]       ## predicted log(counts)
#     age_eff[i] <- b_age*(age[i])  ## effect of age group
#     pred[i] <- exp(logmean0[i] + age_eff[i])
#     rate[i] ~ dpois(pred[i]) 
#   }
#   
#   ## define priors in a loop
#   for (i in 1:nseason) {
#     b_season[i] ~ dnorm(0,0.001)
#   }
#   
#   b_age ~ dnorm(0,0.001)
# }
# 
# jags.fit <- jags(data=covidDat1,
#            inits=NULL,
#            parameters=c("b_season","b_age"),
#            model.file=agetimemodel)

## My apologies for this assignment being so late! I am still a bit confused about using 
## Bayesian statistics in practice, and specifically using it to get insight at how a 
## predictor variable affects an outcome variable -- I am most familiar with using Bayesian statistics 
## for parameter estimation (i.e., I've seen Bayesian data augmentation for estimating beta / gamma in
## an SIR model using data of removal times) and I don't know how to translate that to using MCMC methods
## for this kind of data/question (how does age affect hospitalizations). So, I apologize if my models in this
## assignment don't make much sense!



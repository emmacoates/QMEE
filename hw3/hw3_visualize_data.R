# Week 3 assignment 
# Visualizes cleaned data from hw2

library(readr)
library(dplyr)
library(tidyr)
library(ggplot2); theme_set(theme_bw(base_size = 14)); library('wesanderson') 

dat <- readRDS("hw2/tmp/respTableClean.rds") # load cleaned data


## time series ----------------------------------------------------------------
## creating time series plots aggregated by age, sex, race/ethnicity, and site 
## location to visualize any noticeable differences among the groups

timeDat <- ( dat 
            |> filter(Network != 'Combined') # remove combined network (only want to look at separate networks for now)
) 

timeseries <- ( ggplot(timeDat)
         + aes(x=endingDate, y=weeklyRate, color=Network)
         + geom_line()
         + xlab('')
         + ylab('Rate of disease incidence')
         + scale_colour_manual(values=c(wes_palette('Cavalcanti1'))) ## change palette
) # creating time series plots

## TOFIX: figure out how to re-order facets -- want ages in order, and all
## 'Overall' plots to be last -- order through data-set or through ggplot? 
print(timeseries + facet_wrap(~ageGroup)) # aggregating plots by age 
print(timeseries + facet_wrap(~Sex)) # aggregating plots by sex
print(timeseries + facet_wrap(~Race)) # aggregating plots by race
print(timeseries + facet_wrap(~Site)) # aggregating plots by site location 



## box plots -----------------------------------------------------------------
## creating box plots aggregated by age, sex, and race/ethnicity 
## to further help visualize any noticable differences among groups
## (not making one for site location since there are too many sites and the plot
## would be too busy and hard to read)
## box plots may not be useful for a data-set this large ? 
### by age ------------------------------------------------------------------
bdatAge <- ( dat 
            |> filter(Network != 'Combined',
                      ageGroup != 'Overall')
)

boxplotAge <- (ggplot(bdatAge,aes(x=ageGroup,y=cumulativeRate,
                       colour=Network))
       + geom_boxplot(outlier.colour=NULL)  ## set outlier points to same colour as boxes
       + scale_y_log10()
       + labs(y="Cumulative rate of disease incidence")
)

bdatAge_sort <- bdatAge %>% mutate(across(ageGroup,~forcats::fct_reorder(.,cumulativeRate)))

print(boxplotAge
      %+% bdatAge_sort  ## substitute sorted data
      + coord_flip()      ## rotate entire plot
      + xlab("")          ## x-label redundant
      + scale_colour_manual(values=c(wes_palette('FantasticFox1'))) ## change palette
)

### by sex ------------------------------------------------------------------
bdatSex <- ( dat 
             |> filter(Network != 'Combined',
                       Sex != 'Overall')
)

boxplotSex <- (ggplot(bdatSex,aes(x=Sex,y=cumulativeRate,
                               colour=Network))
            + geom_boxplot(outlier.colour=NULL)  ## set outlier points to same colour as boxes
            + scale_y_log10()
            + labs(y="Cumulative rate of disease incidence")
)

bdatSex_sort <- bdatSex %>% mutate(across(Sex,~forcats::fct_reorder(.,cumulativeRate)))

print(boxplotSex
      %+% bdatSex_sort  ## substitute sorted data
      + coord_flip()      ## rotate entire plot
      + xlab("")          ## x-label redundant
      + scale_colour_manual(values=c(wes_palette('FantasticFox1'))) ## change palette
)

### by race/ethnicity ---------------------------------------------------------
bdatRace <- ( dat 
             |> filter(Network != 'Combined',
                       Race != 'Overall')
)

boxplotRace <- (ggplot(bdatRace,aes(x=Race,y=cumulativeRate,
                               colour=Network))
            + geom_boxplot(outlier.colour=NULL)  ## set outlier points to same colour as boxes
            + scale_y_log10()
            + labs(y="Cumulative rate of disease incidence")
)

bdatRace_sort <- bdatRace %>% mutate(across(Race,~forcats::fct_reorder(.,cumulativeRate)))

print(boxplotRace
      %+% bdatRace_sort  ## substitute sorted data
      + coord_flip()      ## rotate entire plot
      + xlab("")          ## x-label redundant
      + scale_colour_manual(values=c(wes_palette('FantasticFox1'))) ## change palette
)


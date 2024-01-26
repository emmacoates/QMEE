# Week 3 assignment 
# Visualizes cleaned data from hw2

library(readr)
library(dplyr)
library(tidyr)
library(ggplot2); theme_set(theme_bw(base_size = 14))
install.packages('wesanderson'); library('wesanderson') ## setting themes 

dat <- readRDS("hw2/tmp/respTableClean.rds") # load cleaned data

## NOTE FOR ALL PLOTS: hospitalization rate = number of residents in a surveillance 
##                      area who are hospitalized with laboratory-confirmed tests  

## Time series ----------------------------------------------------------------
## Creating time series plots aggregated by age, sex, race/ethnicity, and site 
## location to visualize any noticeable differences among the groups. 
## Focusing on visualizing disparities in hospitalization rates among groups,  
## not focusing on differences between the diseases themselves in these plots. 

timeDat <- ( dat |> filter(Network != 'Combined') ) # remove combined network (only want to look at separate networks for now)  

timeseries <- ( ggplot(timeDat)
         + aes(x=endingDate, y=weeklyRate, color=Network)
         + geom_line(size = 0.75)
         + xlab('')
         + ylab('Weekly hospitalization rates')
         + scale_colour_manual(values=c(wes_palette('Cavalcanti1'))) ## change palette
) # creating time series plots

## TOFIX: figure out how to re-order facets -- want ages in order, and all
## 'Overall' plots to be last -- order through data-set or through ggplot? 
print(timeseries + facet_wrap(~ageGroup)) # aggregating plots by age 
print(timeseries + facet_wrap(~Sex)) # aggregating plots by sex
print(timeseries + facet_wrap(~Race)) # aggregating plots by race
print(timeseries + facet_wrap(~Site)) # aggregating plots by site location (some missing data for a few sites)


## Box plots -----------------------------------------------------------------
## Creating box plots aggregated by age, sex, and race/ethnicity 
## to further help visualize any noticeable differences among groups
## (not making one for site location since there are too many sites and the plot
## would be too busy and hard to read).
## Again, focusing on visualizing disparities in hospitalization rates among groups,
## not focusing on differences between the diseases themselves in these plots. 
## Box plots may not be useful for a data-set this large...? Trying to just spot 
## any glaring/obvious differences
### by age ------------------------------------------------------------------
bdatAge <- ( dat 
             |> filter(Network != 'Combined',
                       ageGroup != 'Overall')
)

boxplotAge <- ( ggplot(bdatAge,aes(x=ageGroup,y=weeklyRate,
                       colour=Network))
       + geom_boxplot(outlier.colour=NULL)  ## set outlier points to same colour as boxes
       + scale_y_log10()
       + ylab('Weekly hospitalization rates')
)

bdatAge_sort <- bdatAge |> mutate(across(ageGroup,~forcats::fct_reorder(.,weeklyRate)))

print( boxplotAge
      %+% bdatAge_sort  ## substitute sorted data
      + coord_flip()      ## rotate entire plot
      + xlab('')          ## x-label redundant
      + scale_colour_manual(values=c(wes_palette('FantasticFox1'))) ## change palette
)

### by sex ------------------------------------------------------------------
bdatSex <- ( dat 
             |> filter(Network != 'Combined',
                       Sex != 'Overall')
)

boxplotSex <- ( ggplot(bdatSex,aes(x=Sex,y=weeklyRate,
                               colour=Network))
            + geom_boxplot(outlier.colour=NULL)  ## set outlier points to same colour as boxes
            + scale_y_log10()
            + ylab('Weekly hospitalization rates')
)

bdatSex_sort <- bdatSex |> mutate(across(Sex,~forcats::fct_reorder(.,weeklyRate)))

print( boxplotSex
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

boxplotRace <- ( ggplot(bdatRace,aes(x=Race,y=weeklyRate,
                               colour=Network))
            + geom_boxplot(outlier.colour=NULL)  ## set outlier points to same colour as boxes
            + scale_y_log10()
            + ylab('Weekly hospitalization rates')
)

bdatRace_sort <- bdatRace |> mutate(across(Race,~forcats::fct_reorder(.,weeklyRate)))

print( boxplotRace
      %+% bdatRace_sort  ## substitute sorted data
      + coord_flip()      ## rotate entire plot
      + xlab("")          ## x-label redundant
      + scale_colour_manual(values=c(wes_palette('FantasticFox1'))) ## change palette
)


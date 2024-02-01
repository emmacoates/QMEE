## Week 3 assignment 
## Visualizes cleaned data from hw2

library(readr)
library(dplyr)
library(tidyr)
library(ggplot2); theme_set(theme_bw(base_size = 14))

## BMB: please *don't* include install.packages()
##  in code -- leave that decision up to the person running the code

library('wesanderson') ## setting themes 

dat <- readRDS("hw2/tmp/respTableClean.rds") ## load cleaned data

## NOTE FOR ALL PLOTS: hospitalization rate = number of residents in a surveillance 
##                      area who are hospitalized with laboratory-confirmed tests  

## Time series ----------------------------------------------------------------
## Creating time series plots aggregated by age, sex, race/ethnicity, and site 
## location to visualize any noticeable differences among the groups. 
## Focusing on visualizing disparities in hospitalization rates among groups,  
## not focusing on differences between the diseases themselves in these plots. 

timeDat <- ( dat |> filter(Network != 'Combined') ) ## remove combined network (only want to look at separate networks for now)  

timeseries <- ( ggplot(timeDat)
         + aes(x=endingDate, y=weeklyRate, color=Network)
         + geom_line(linewidth = 0.65)
         + xlab('')
         + ylab('Weekly hospitalization rates')
         + scale_colour_manual(values=c(wes_palette('Cavalcanti1'))) ## change palette
) ## creating time series plots

## TOFIX: figure out how to re-order facets -- want ages in order, and all
## 'Overall' plots to be last -- order through data-set or through ggplot?

## BMB: ordering is by data set
ag <- gtools::mixedsort(levels(droplevels(timeDat$ageGroup)))
timeDat_ordered <- (timeDat
    |> mutate(across(ageGroup, ~factor(., levels = ag)))
    ## put "Overall" last
    |> mutate(across(Race, ~ forcats::fct_relevel(., "Overall", after = Inf)))
)

## %+% substitutes new data (we could/should do the reordering upstream though)
print(timeseries %+% timeDat_ordered + facet_wrap(~ageGroup)) ## aggregating plots by age 
print(timeseries + facet_wrap(~Sex)) ## aggregating plots by sex
print(timeseries %+% timeDat_ordered + facet_wrap(~Race)) ## aggregating plots by race

## BMB: definitely want to put 'overall' last. Should probably reorder states somehow,
##  but I'm not sure how (unless readers will want to look up particular states)
print(timeseries + facet_wrap(~Site)) ## aggregating plots by site location (some missing data for a few sites)


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

boxplotAge <- ( ggplot(bdatAge, aes(x = ageGroup, y = weeklyRate, colour = Network)) 
                + geom_boxplot(outlier.colour=NULL)  ## set outlier points to same colour as boxes 
                + ylab('Weekly hospitalization rates')
)

## BMB: probably want to fill in boxes (see Claus Wilke book)
wp_light <- wes_palette('FantasticFox1') |> adjustcolor(alpha = 0.3)
print( boxplotAge
       + coord_flip()      ## rotate entire plot
       + xlab('')          ## x-label redundant
      + scale_colour_manual(values=wes_palette('FantasticFox1')) ## change palette
      + aes(fill = Network)
      + scale_fill_manual(values=wp_light) ## change palette
)

### by sex ------------------------------------------------------------------
bdatSex <- ( dat 
             |> filter(Network != 'Combined',
                       Sex != 'Overall')
)

boxplotSex <- ( ggplot(bdatSex,aes(x = Sex, y = weeklyRate, colour = Network))
                + geom_boxplot(outlier.colour=NULL)  ## set outlier points to same colour as boxes
                + ylab('Weekly hospitalization rates')
)


print( boxplotSex
       + coord_flip()      ## rotate entire plot
       + xlab("")          ## x-label redundant
       + scale_colour_manual(values=c(wes_palette('FantasticFox1'))) ## change palette
)

### by race/ethnicity ---------------------------------------------------------
bdatRace <- ( dat 
             |> filter(Network != 'Combined',
                       Race != 'Overall')
)

boxplotRace <- ( ggplot(bdatRace,aes(x = Race, y = weeklyRate, colour = Network))
                 + geom_boxplot(outlier.colour=NULL)  ## set outlier points to same colour as boxes
                 + ylab('Weekly hospitalization rates')
)

print( boxplotRace
       + coord_flip()      ## rotate entire plot
       + xlab("")          ## x-label redundant
       + scale_colour_manual(values=c(wes_palette('FantasticFox1'))) ## change palette
)

## BMB: could probably repeat a *little* less code ...

## TOFIX: warning messages from box plot transformation 
## Warning messages:
## 1: Transformation introduced infinite values in continuous y-axis 
## 2: Removed 381 rows containing non-finite values (`stat_boxplot()`). 
## Cause: putting the box plots on a log scale improves readability, but ignores rates = 0 -- 
## removed log scale from box plots to include rates = 0 -- does this make the plots hard to read?

## BMB: I don't mind these particular warning messages.
## rates equal to zero actually get moved to the very edge of the plot
## JD points out that you can use e.g. scale_x_continuous(trans = "log1p") to get a log(1+x)-transformation

## By the way, you don't need coord_flip -- you can actually specify e.g. x = weeklyRate, y = Race
## and go from there. That makes some things easier (there are a few tricks that don't play nicely with coord_flip())

## mark: 2.1

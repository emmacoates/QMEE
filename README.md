# QMEE
Repository for BIO 708 and testing my Git/GitHub setup.
This is a line from RStudio.

## Week 1 assignment: CDC RESP-NET data
COVID-NET, RSV-NET, and FluSurv-NET (RESP-NET) are population-based surveillance systems that collect data on laboratory-confirmed hospitalizations among children and adults through a network of over 250 acute-care hospitals in 14 states. RESP-NET collects surveillance data on laboratory-confirmed, RESP-associated hospitalizations, including those resulting in ICU admission or death, among children and adults. Data are collected and reported from a network of sites in acute-care hospitals during the October 1–April 30 season each year. The .csv file "Rates_of_Laboratory-Confirmed_RSV__COVID-19__and_Flu_Hospitalizations_from_the_RESP-NET_Surveillance_Systems_20240115.csv" contains hospitalization rates for Covid-19, RSV, and flu from 2018-2023 aggregated by disease, age, race/ethnicity, and gender. Hospitalization rates are calculated as the number of residents in a surveillance area who are hospitalized with laboratory-confirmed Covid-19/RSV/flu divided by the total population estimate for that area. 
https://data.cdc.gov/Public-Health-Surveillance/Rates-of-Laboratory-Confirmed-RSV-COVID-19-and-Flu/kvib-3txy/about_data

The biological questions I would hope to answer about these data include do the spread of these respiratory viruses have an advantageous affect on one another and are there disease prevalence disparities present between genders, ages, and races and if so, what mechanisms lead to these disparities. 

## Week 2 assignment: Cleaning data/saving & loading .rds files
'clean_resp_data.R' cleans the data described above (CDC RESP-NET data). The data seems to be already clean (I think), besides some missing data for sites in North Carolina. This script removes any missing data, which seems to be the only component of the data needing cleaning. The script additionally saves the cleaned version of the data to an .rds file 'respTableClean.rds.' 

'resp_data_analysis.R' reads in the .rds file of the cleaned data ('respTableClean.rds'), and calculates the mean rate of infection for each flu/RSV/COVID for each year for data combined from all genders, races/ethnicities, age groups, and geographical locations/sites. 

Both scripts should be run from the QMEE directory. 

The data is aggregated by race/ethnicity, gender, age group, and geographical location, so these data could be used to investigate existing disparities across different demographic categories and what mechanisms lead to said disparities. These data could also be used to investigate the effect the spread of RSV/COVID/Flu have on one another given these data are also aggregated by respiratory disease. 
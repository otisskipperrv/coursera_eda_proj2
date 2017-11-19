

library(tidyverse)
library(stringr)
setwd('/Users/oskipper/Documents/Data Science/DSAccelerator/SecondPhase/Coursera/ExploratoryDataAnlysis/coursera_eda_proj2/Accelerator Work/')

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")



# _Yearly Delta Calculation_  
# Given a data set with fips/SCC values and emission values for various years (fips/SCC & years in rows, emission values in columns) transforms the data set to be grouped by fips/SCC with each column being a year and the observation values being the emissions for that year. Also calculates the chage (`totalDelta`) for between the year 1999 and 2008. 
# We can then create a secondary fucntion fips_yearly_delta that does the same thing but just groups by fips


fips_yearly_delta <- function(fips_data){
  
  output <-  fips_data %>%
    mutate(fips = as.numeric(fips)) %>%
    group_by(fips, year) %>%
    summarise(totalEmissions = sum(Emissions)) %>%
    spread(key = year, value = totalEmissions) %>%
    filter(!is.na(`1999`), !is.na(`2008`)) %>%
    mutate(totalDelta = (`2008`-`1999`)/(`1999`)*100)
  
  output
}



# Question 1

p1 <- NEI %>% 
  group_by(year) %>% 
  summarise(total_emisions = sum(Emissions))


xlabs <- c('1999', '2002','2005', '2008')

plot(p1$year, p1$total_emisions, type = "l", 
     main = "Total US Emissions Over Time", 
     xaxt = "n",
     xlab = "Year",
     ylab = "PM2.5 Total Emissions (tons)")
axis(1, at = xlabs, labels = xlabs, las = 0)


```
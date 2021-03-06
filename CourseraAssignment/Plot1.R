

library(tidyverse)
# Set to working directory 
setwd('/Users/oskipper/Documents/Data Science/DSAccelerator/SecondPhase/Coursera/ExploratoryDataAnlysis/coursera_eda_proj2/CourseraAssignment/')
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# Question 1

p1 <- NEI %>% 
  group_by(year) %>% 
  summarise(total_emisions = sum(Emissions))


xlabs <- c('1999', '2002','2005', '2008')

png('plot1.png')
plot(p1$year, p1$total_emisions, type = "l", 
     main = "Total US Emissions Over Time", 
     xaxt = "n",
     xlab = "Year",
     ylab = "PM2.5 Total Emissions (tons)")
axis(1, at = xlabs, labels = xlabs, las = 0)

dev.off()

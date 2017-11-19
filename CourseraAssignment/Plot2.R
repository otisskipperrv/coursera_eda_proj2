

library(tidyverse)
# Set to working directory 
setwd('/Users/oskipper/Documents/Data Science/DSAccelerator/SecondPhase/Coursera/ExploratoryDataAnlysis/coursera_eda_proj2/CourseraAssignment/')


NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


p2 <- NEI %>% 
  filter(fips == 24510) %>% 
  group_by(year) %>% 
  summarise(total_emisions = sum(Emissions)) 

png('plot2.png')
xlabs <- c('1999', '2002','2005', '2008')
plot(p2$year, p2$total_emisions, type = "l",
     main = "Total Emissions Over Time In Baltimore", 
     xaxt = "n",
     xlab = "Year",
     ylab = "PM2.5 Total Emissions (tons)")
axis(1, at = xlabs, labels = xlabs, las = 0)
dev.off()

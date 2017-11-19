library(tidyverse)
library(stringr)
# Set to working directory 
setwd('/Users/oskipper/Documents/Data Science/DSAccelerator/SecondPhase/Coursera/ExploratoryDataAnlysis/coursera_eda_proj2/CourseraAssignment/')

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")



NEISCC <- NEI %>% 
  left_join(SCC, by = 'SCC')

SCC_veh <- SCC %>% 
  filter(str_detect(SCC.Level.Two, regex('motor|vehicle', ignore_case = T)) == TRUE | 
           str_detect(EI.Sector, regex('motor|vehicle', ignore_case = T)) == TRUE)

p5 <- NEI %>% 
  filter(fips == '24510') %>% 
  inner_join(SCC_veh, by = 'SCC') %>% 
  group_by(year) %>% 
  summarise(totalEmissions = sum(Emissions)) %>% 
  ggplot(aes(x = year, y =totalEmissions)) + 
  geom_line()+
  xlab("Year") +
  ylab("PM2.5 Emissions (tons)") +
  ggtitle("Baltimore Motor Vehicle Total Emissions Over Time") +
  scale_x_continuous(breaks = seq(1999, 2008, 3))

png('plot5.png')
plot(p5)
dev.off()

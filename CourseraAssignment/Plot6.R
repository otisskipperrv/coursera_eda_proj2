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

p6 <- NEI %>% 
  filter(fips == '24510' | fips == '06037') %>% 
  inner_join(SCC_veh, by = 'SCC') %>% 
  group_by(year, fips) %>% 
  summarise(totalEmissions = sum(Emissions)) %>% 
  ggplot(aes(x = year, y =totalEmissions, fill = fips)) + 
  geom_bar(stat = "identity", position = "dodge")+
  xlab("Year") +
  ylab("PM2.5 Emissions (tons)") +
  ggtitle("Los Angeles vs. Baltimore Motor Vehicle Total Emissions Over Time") +
  scale_x_continuous(breaks = seq(1999, 2008, 3)) + 
  facet_wrap(~fips, scale = "free") + 
  scale_fill_discrete(labels = c("Los Angeles", "Baltimore"))

png('plot6.png')
plot(p6)
dev.off()

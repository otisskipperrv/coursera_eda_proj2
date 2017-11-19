library(tidyverse)
library(stringr)
# Set to working directory 
setwd('/Users/oskipper/Documents/Data Science/DSAccelerator/SecondPhase/Coursera/ExploratoryDataAnlysis/coursera_eda_proj2/CourseraAssignment/')

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


NEISCC <- NEI %>% 
  left_join(SCC, by = 'SCC')

# Seems like this one is a good limitation
coalComb <- NEISCC %>% 
  mutate(isCoalCombustion = str_detect(EI.Sector, regex('coal.*comb|comb.*coal', ignore_case = T))) %>% 
  filter(isCoalCombustion == TRUE) 

p4 <- coalComb %>%   
  group_by(year, EI.Sector) %>% 
  summarise(totalEmissions = sum(Emissions)) %>% 
  ggplot(aes(x = year, y = totalEmissions, color = EI.Sector, ))+
  geom_line() + 
  xlab("Year") +
  ylab("PM2.5 Emissions (tons)") +
  ggtitle("Coal Combustion Emissions by Sector Over Time") +
  scale_x_continuous(breaks = seq(1999, 2008, 3))

png('plot4.png')
plot(p4)
dev.off()

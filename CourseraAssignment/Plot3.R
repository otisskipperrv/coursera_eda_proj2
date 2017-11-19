

library(tidyverse)
# Set to working directory 
setwd('/Users/oskipper/Documents/Data Science/DSAccelerator/SecondPhase/Coursera/ExploratoryDataAnlysis/coursera_eda_proj2/CourseraAssignment/')

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Question 3
#__Question:__
#Of the four types of sources indicated by the 𝚝𝚢𝚙𝚎 (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.


p3 <- NEI %>% 
  group_by(year, type) %>% 
  filter(fips == 24510) %>%
  summarise(totalEmissions = sum(Emissions)) %>% 
  ggplot(aes(x = year, y = totalEmissions, color = type, ))+
  geom_line() + 
  xlab("Year") +
  ylab("PM2.5 Emissions (tons)") +
  ggtitle("Emissions by Emission Type Over Time") +
  scale_x_continuous(breaks = seq(1999, 2008, 3))

png('plot3.png')
plot(p3)
dev.off()

setwd("E:/projects/data incubator/QuestionThree/Question3")
libs = c("readr", "dplyr", "tidyverse", "magrittr", "tidyr", "ggplot2", "rgeos",
         "usmap")
lapply(libs, require, character.only = TRUE)
alldata<- read_csv("sentences.csv")

###########################################
### Clean the Data
names(alldata)
alldata<-subset(alldata, select = c("defendant", "year", "state", "county", "def_race",
                                    "def_gender", "Executed", "DateofExecution"))


alldata[which(alldata[,3]=='Floridaorida', arr.ind=TRUE), 3] <- 'Florida'
alldata[which(alldata[,3]=='Nebraskabraska', arr.ind=TRUE), 3] <- 'Nebraska'

View(alldata)
########################################################
# Create heat Map

alldata.map<- alldata %>% group_by(state, year) %>% mutate(count = n())
use.for.map <- unique(subset(alldata.map, select=c(state, count, year)))
View(use.for.map)

plot_usmap(data = use.for.map, values = "count", regions = "states") + 
  labs(title =  "Death sentences in the United States by State.") + 
  theme(panel.background = element_rect(colour = "black", fill = "lightblue"))+
  scale_fill_continuous(name = "Number of Death Sentences", label = scales::comma) + 
  theme(legend.position = "right")

use.for.map1<- subset(use.for.map, count>=30)
View(use.for.map)
calculateraio<-function(count, population){
  ratio<-(count/population)*1000000
  return(ratio)
}

ggplot(data=use.for.map1, aes(x=sort(state), y=count)) +
  geom_bar(fill="#DD8888", width=.8, stat="identity")+
  xlab("Year") + ylab("Number of death sentences") +
  ggtitle("A Bar Graph Showng the Number of Death Sentences by State for States with
sentences greter than 100 since 1991")


# Create bar graph based on years
alldata.graph<- alldata %>% group_by(year) %>% mutate(count = n())
use.for.graph <- unique(subset(alldata.graph, select=c(year, count)))
View(use.for.graph)

ggplot(data=use.for.graph, aes(x=year, y=count)) +
  geom_bar(fill="#DD8888", width=.8, stat="identity")+
  xlab("Year") + ylab("Number of death sentences") +
  ggtitle("A Bar Graph Showng the Number of Death Sentences by Year")


population_2000 <- read_csv("population_2000.csv")

population_2010 <- read_csv("population_2010.csv")
population_2017 <- read_csv("population_2017.csv")

population_2010 <- aggregate(. ~ state, data=population_2010, FUN=sum)


population_2000$state==population_2010$state
population_2017$state==population_2010$state

populationdata<-merge(population_2000, population_2010, by = 'state')
populationdata<-merge(populationdata, population_2017, by = 'state')

colSums(populationdata[sapply(populationdata, is.numeric)], na.rm = TRUE)

View(populationdata)




alldata$Executed[is.na(alldata$Executed)] <- "No"

View(alldata)


categories = c("state","county","def_race","def_gender", "Executed")
alldata[categories] <- lapply(alldata[categories], factor)




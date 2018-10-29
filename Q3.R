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

use.for.map<-dplyr::filter(use.for.map,state!="Federal")



# Since the number of peple sentenced from each state may be inflated by the population
# of different states, wefind the count as a ratio of every states total population for
# every year.

population_2000 <- read_csv("population_2000.csv")

population_2010 <- read_csv("population_2010.csv")
population_2017 <- read_csv("population_2017.csv")

population_2010 <- aggregate(. ~ state, data=population_2010, FUN=sum)


populationdata<-merge(population_2000, population_2010, by = 'state')
populationdata<-merge(populationdata, population_2017, by = 'state')


calculateratios<-function(df1, df2){
  sentences.2.population <- vector(mode="numeric", length=0)
  
  for (row in 1:nrow(df1)) {
    state <- df1[row, "state"]
    count  <- df1[row, "count"]
    year  <- df1[row, "year"]
    
    ans<-which(df2 == paste(state), arr.ind = T)
    year.population<-df2[(ans[,1]),as.character(year)]
    print(c(paste(count), paste(year.population)))
    if (year.population>0){
      ratio<- (count/year.population)*100000
    }else{
      ratio<-"NA"
    }
    
    sentences.2.population <- c(sentences.2.population, paste(ratio))
    
  }
  return(sentences.2.population)

}

myratios<- c(calculateratios(use.for.map, populationdata))
myratios


plot_usmap(data = use.for.map, values = "count", regions = "states") + 
  labs(title =  "Death sentences in the United States by State.") + 
  theme(panel.background = element_rect(colour = "black", fill = "lightblue"))+
  scale_fill_continuous(name = "Number of Death Sentences", label = scales::comma) + 
  theme(legend.position = "right")

use.for.map1<- subset(use.for.map, count>=30)
View(use.for.map)


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







alldata$Executed[is.na(alldata$Executed)] <- "No"

View(alldata)


categories = c("state","county","def_race","def_gender", "Executed")
alldata[categories] <- lapply(alldata[categories], factor)




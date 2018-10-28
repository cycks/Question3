libs = c("readr", "dplyr", "tidyverse", "magrittr", "tidyr", "ggplot2", "rgeos",
         "usmap")
lapply(libs, require, character.only = TRUE)
sentences<- read_csv("E:/projects/data incubator/QuestionThree/sentences.csv")



names(alldata)
alldata<-subset(alldata, select = c("defendant", "year", "state", "county", "def_race",
                                    "def_gender", "Executed", "DateofExecution"))


alldata[which(alldata[,3]=='Floridaorida', arr.ind=TRUE), 3] <- 'Florida'
alldata[which(alldata[,3]=='Nebraskabraska', arr.ind=TRUE), 3] <- 'Nebraska'




alldata<- alldata %>% group_by(state) %>% mutate(count = n())
use.for.map <- unique(subset(alldata, select=c(state, count)))
View(use.for.map)

plot_usmap(data = use.for.map, values = "count", regions = "states") + 
  labs(title =  "Death sentence in the United States by State.") + 
  theme(panel.background = element_rect(colour = "black", fill = "lightblue"))+
  scale_fill_continuous(name = "Number of Death Sentences", label = scales::comma) + 
  theme(legend.position = "right")












alldata$Executed[is.na(alldata$Executed)] <- "No"

View(alldata)


categories = c("state","county","def_race","def_gender", "Executed")
alldata[categories] <- lapply(alldata[categories], factor)




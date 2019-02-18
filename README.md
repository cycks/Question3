# The American Death Sentences Dataset
### Table of Contents
1. [Introduction](#Introduction)
2. [Objectives](#Objectives)
# Introduction
Garret, Jakubow, and Desai (2017), conducted a study on death sentences in the United States of America.
The publication could be found [here](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=2911016), while
the data set could be found [here](http://endofitsrope.com/wp-content/uploads/2018/03/1991_2017_individualFIPS.csv-1991_2017_individualFIPS.csv). 

Desai and Garret (2019) examined the same dataset for state level death sentences, a study that could be 
found [here](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=3124455). I too will be examining the same 
data set, but with different objectives in mind. Specifcally, I will be seeking to meet the objectives below,
but I could stray from the objectives depending on the direction I will take when exploring the data set

#### Objectives
1. Examine whether there is a difference in death sentences based on Race.
2. Build a machine learning model to predict whether someone with a death sentence will be executed.
3. Create a shinny dashboard to display the number of death sentences per state.
4. Create a shinny dashboard to display the number of death sentences by county.
5. Improve on the current state of the data set by finding and replacing missing values

### Data Preparation
The original data set, while it could be used in its original state, was cleaned to meet the objectives of the 
researcher. 
1. Columns with too many missing values were removed
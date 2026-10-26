# US Death Sentences Analysis

An exploratory data analysis (EDA) project built in **R** that examines historical death sentence data across the United States. This project processes raw sentence records, cleans state-level inconsistencies, normalizes data against state populations across multiple census years, and generates geographic heatmaps and comparative bar charts.

---

## 🚀 Key Features

* **Data Cleaning & Standardization:** Handles typos in state names (e.g., *Floridaorida*, *Nebraskabraska*, *OKlahoma*), filters out non-state jurisdictions (*Federal*, *U.S. Military*), and cleans missing execution records.
* **Per-Capita Normalization:** Computes death sentence rates relative to state population statistics across multiple benchmark years (2000, 2010, and 2017).
* **Geospatial & Statistical Visualizations:**
  * US state-level geographic distribution maps using `usmap`.
  * Comparative bar charts for high-frequency states (thresholds $\ge 100$ and $\ge 200$ sentences).
  * Population-adjusted ratio graphs.
  * Temporal trend analysis showing death sentences broken down by year.

---

## 🛠️ Prerequisites & Dependencies

To run this script successfully, make sure you have R installed along with the following packages:

```R
install.packages(c("readr", "dplyr", "tidyverse", "magrittr", "tidyr", "ggplot2", "rgeos", "usmap"))
```

---

## 📂 Project Structure

```text
Question3/
│
├── dataset/
│   ├── sentences.csv        # Main dataset containing defendant details and sentencing records
│   ├── population_2000.csv  # State population data for 2000
│   ├── population_2010.csv  # State population data for 2010
│   └── population_2017.csv  # State population data for 2017
│
└── analysis.R               # Main R script containing data cleaning, ratio calculations, and plots
```

---

## 📊 Data Workflow

1. **Import & Subset:** Loads sentencing records and selects key variables: defendant, year, state, county, race, gender, execution status, and execution date.
2. **Data Hygiene:** Corrects misspelled state strings and filters records to focus strictly on US states.
3. **Population Merging & Ratios:** Merges multi-year population datasets and applies a custom matching function (`calculateratios`) to derive population-adjusted metrics.
4. **Categorical Conversion:** Cleans missing execution flags (`NA` $\rightarrow$ `"No"`) and converts categorical attributes into R factors for downstream modeling or analysis.

---

## 📈 Visualizations

The script generates several `ggplot2` and `usmap` visualizations:
* **Geographic Map:** Displays spatial distribution of death sentences across US states.
* **State Bar Plots:** Highlights states with cumulative death sentences exceeding 100 and 200.
* **Per-Capita Bar Plot:** Visualizes the ratio of death sentences relative to population scale.
* **Temporal Trend Plot:** Illustrates the frequency of sentences across years.

---

## ⚙️ Usage

1. Open your R environment (such as RStudio).
2. Set your working directory to the project folder:
   ```R
   setwd("~/path/to/Question3")
   ```
3. Run the script sections sequentially to load dependencies, process
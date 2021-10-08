library(tidyverse)
library(tidyr)
library(dplyr)
library(readxl)
library(data.table)
# Year 1799 - 2049
# including 195 countries
# data_1: lifer expectancy in different countries from 1799 to 2049(expected)
# data_2: income per person(gdp) in different countries from 1799 to 2049(expected)
data_1 <- read.csv("https://raw.githubusercontent.com/MA615-Yifan/MA615_hw2/main/life_expectancy_years.csv",
                   header = TRUE)
data_1 <- data_1[,1:252]
data_2 <- read.csv("https://raw.githubusercontent.com/MA615-Yifan/MA615_hw2/main/income_per_person_gdppercapita_ppp_inflation_adjusted.csv",
                   header = TRUE)
country_n <- dim(data_1)[1]
year_n <- dim(data_1)[2] - 1
# data tidy
sorted_1 <- data_1 %>%
  pivot_longer(-country, names_to = "year", values_to = "life_expectancy")
sorted_1$year <- as.numeric(sub('X', '', sorted_1$year))
sorted_1$life_expectancy <- as.numeric(sorted_1$life_expectancy)

data_2 <- data.frame(lapply(data_2, as.character), stringsAsFactors=FALSE)
sorted_2 <- data_2 %>%
  pivot_longer(-country, names_to = "year", values_to = "income_per_person")
sorted_2$year <- as.numeric(sub('X', '', sorted_1$year))
sorted_2$income_per_person <- as.numeric(sub("k", "e3", sorted_2$income_per_person))
data <- cbind(sorted_1, sorted_2[, 3])
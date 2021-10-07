library(tidyverse)
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
# construct different indicators
country <- vector()
for (i in 1: country_n) {
  country <- c(country, rep(data_1$country[i], year_n))
}
life_expect <- vector()
for (i in 1: country_n){
  a <- data_1[i, ]
  b <- unlist(a)
  life_expect <- c(life_expect, as.numeric(b[2:(year_n + 1)]))
}
income_per_person <- vector()
for (i in 1: country_n) {
  a <- data_2[i, ]
  b <- unlist(a)
  income_per_person <- c(income_per_person, as.numeric(
    sub("k", "e3", b[2:(year_n + 1)], fixed = TRUE)))
}
year <- as.numeric(rep(c(1799:2049), country_n))
data <- data.frame(country, year, life_expect, income_per_person)

# filtering a column to see whether the data with "k" has been successfully converted
# data %>%
#   filter(country == "Australia")






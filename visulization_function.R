data_visulization <- function(data, country1, country2, indicator){
  # country1 <- "China"
  # country2 <- "Australia"
  # indicator <- "life_expect"
  # indicator <- as.character(indicator)
  if(dim(filter(data, country == country1))[1] == 0 | dim(filter(data, country == country2))[1] == 0){
    stop("warning: country does not exist.")
  }
  if(indicator == "life"){
    data1 <- data %>%
      filter(country == country1)
    data2 <- data %>%
      filter(country == country2)
    mean_year <- data %>% group_by(year) %>%
      summarize(mean = mean(life_expect, na.rm = TRUE))
    mean_year <- data.frame(country = rep("world mean", dim(mean_year)[1]), year = mean_year$year, life_expect = mean_year$mean)
    plot_data <- rbind(data.frame(country = data1$country, year = data1$year, life_expect = data1$life_expect),
                       data.frame(country = data2$country, year = data2$year, life_expect = data2$life_expect),
                       mean_year)
    ggplot(data = plot_data, mapping = aes(x = year, y = life_expect, 
                                           group = country, color = country, shape = country), xlim = c(1799, 2049)) +
      geom_line() + geom_point(size = .7) + 
      xlab("Year") + ylab("life expectancy")
  } 
  else if(indicator == "income"){
    data1 <- data %>%
      filter(country == country1)
    data2 <- data %>%
      filter(country == country2)
    mean_income <- data %>% group_by(year) %>%
      summarize(mean = mean(income_per_person, na.rm = TRUE))
    mean_income <- data %>% group_by(year) %>%
      summarize(mean = mean(income_per_person, na.rm = TRUE))
    mean_income <- data.frame(country = rep("world mean", dim(mean_income)[1]), year = mean_income$year, income_per_person = mean_income$mean)
    plot_data <- rbind(data.frame(country = data1$country, year = data1$year, income_per_person = data1$income_per_person),
                       data.frame(country = data2$country, year = data2$year, income_per_person = data2$income_per_person),
                       mean_income)
    ggplot(data = plot_data, mapping = aes(x = year, y = income_per_person, 
                                           group = country, color = country, shape = country), xlim = c(1799, 2049)) + 
      geom_line() + geom_point(size = .7) + xlab("Year") + ylab("income per person($)")
  } 
  else{
    stop("warning: indicator does not exist. ")
  }
}











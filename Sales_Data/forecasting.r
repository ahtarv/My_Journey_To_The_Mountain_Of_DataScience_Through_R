install.packages("forecast") # downnloading forecast library


library(dplyr)
library(lubridate)
library(ggplot2)
library(forecast)

# all libraries declared

sales_data <- read.csv("data/sales_data.csv") # same as before
sales_data$date <- as.Date(sales_data$date)

monthly_revenue <- sales_data %>%
    mutate(month = floor_date(date, "month")) %>%
    group_by(month) %>%
    summarise(total_revenue = sum(revenue)) %>%
    arrange(month) # same before, no change as far as i can see

re

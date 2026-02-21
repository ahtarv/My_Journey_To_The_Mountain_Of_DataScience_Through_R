library(dplyr)
library(lubridate)
library(ggplot2)

sales_data <- read.csv("data/sales_data.csv") # this is where we read the csv file
sales_data$date <- as.Date(sales_data$date) # this is me reading date from the csv files

monthly_revenue <- sales_data %>%
    mutate(month = floor_date(date, "month")) %>%
    group_by(month) %>%
    summarise(total_revenue = sum(revenue)) %>%
    arrange(month) # same as before , reminds me of sql ngl, like sub queries and all

revenue_ts <- ts(monthly_revenue$total_revenue, start = c(year(min(monthly_revenue$month)), month(min(monthly_revenue$month))), frequency = 12) # also this, no idea

decomp <- decompose(revenue_ts, type = "additive") # ngl no idea what this mean, i understood decomopistion a little bit, and additive as in small amts is added but nah
png("outputs/figures/decomposition.png", width = 800, height = 600)
plot(decomp)
dev.off()

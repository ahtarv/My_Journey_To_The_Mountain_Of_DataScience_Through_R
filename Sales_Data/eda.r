library(ggplot2)
library(dplyr)
library(lubridate) # these are the library used

sales_data <- read.csv("data/sales_data.csv")

sales_data$date <- as.Date(sales_data$date) # so for this i got that i got that i am getting data from sales_data but why i am doing it as.Date? dk need to check that

str(sales_data)
summary(sales_data) # this is the summary

ggplot(sales_data, aes(x = date, y = revenue) + geom_line(alpha = 0.6, color = "steelblue") + labs(title = "Daily Revenue Over Time", x = "Date", y = "Revenue")) +
    theme_minimal() # so all this is same as before, just dk what alpha is and why we do theme_minial()?

monthly_revenue <- sales_data %>%
    mutate(month = floor_date(date, "month")) %>%
    group_by(month) %>%
    summarise(total_revenue = sum(revenue)) # now this is like SQL actually, like group by and all, and sumamrize and all

ggplot(monthly_revenue, aes(x = month, y = total_revenue)) +
    geom_line(size = 1.1, color = "darkgreen") +
    geom_point() +
    labs(title = "Monthly Revenue trend", x = "Month", y = "Total Revenue") +
    theme_minimal()
# so now this is the same as sales data thing, just i replace date with month and revenue with total revenue

ggplot(sales_data, aes(x = category, y = revenue, fill = category) + geom_boxplot(alpha = 0.7) + labs(title = "Revenue Distribution by Category", x = "Category", y = "Revenue")) +
    theme_minimal() +
    theme(legend.position = "none") # this is category wise, same syntax as that of date wise and month wise

sales_data %>% # this symbol once again, first do this then that
    group_by(promotion) %>%
    summarise(
        avg_revenue = mean(revenue),
        median_revenue = median(revenue),
        total_revenue = sum(revenue)
    ) # reminds me of nested queries ngl, like first fetch this and this then that, and just dislay it

ggsave("outputs/figure/monthly_revenue_trend.png", width = 8, height = 5) # this is the plot save funcn as photo. i should play with the widtha nd the height more could be interesting.

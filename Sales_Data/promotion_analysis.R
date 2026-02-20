library(dplyr)
library(ggplot2)

sales_data <- read.csv("data/sales_data.csv")
sales_data$date <- as.Date(sales_data$date)

promo_summary <- sales_data %>%
    group_by(promotion) %>%
    summarise(
        avg_revenue = mean(revenue),
        median_revenue = median(revenue),
        total_revenue = sum(revenue),
        avg_quantity = mean(quantity),
        orders = n()
    )
print(promo_summary)

p1 <- ggplot(sales_data, aes(x = promotion, y = revenue, fill = promotion)) +
    geom_boxplot(alpha = 0.7) +
    labs(title = "Revenue Distribution: Promtion vs No Promotion", x = "Promotion", y = "Revenue") +
    theme_minimal() +
    theme(legend.position = "none")

print(p1)
category_promo <- sales_data %>%
    group_by(category, promotion) %>%
    summarise(avg_revenue = mean(revenue), total_revenue = sum(revenue), .groups = "drop") # didnt understand the .groups things all else was fine

print(category_promo)

p2 <- ggplot(category_promo, aes(x = category, y = avg_revenue, fill = promotion)) +
    geom_bar(stat = "identity", position = "dodge") +
    labs(title = "Average Revenu by Category and Promotion", x = "Category", y = "Average Revenue") +
    theme_minimal()
# this is the second plot
print(p2)

sales_data %>%
    group_by(promotion) %>%
    summarise(
        avg_quanitiy = mean(quantity),
        avg_revenue = mean(revenue)
    )
# this is for quantity vs revenue, to check what is actually happening

ggsave("outputs/figures/promotion_category_revenue.png", p2, width = 8, height = 5)

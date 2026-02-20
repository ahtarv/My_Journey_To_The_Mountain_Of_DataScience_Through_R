set.seed(42)

num_days <- 730
dates <- seq.Date(
    from = as.Date("2023-01-01"),
    by = "day",
    length.out = num_days
) # this is the date generation function, generates date in the interval of one day

products <- data.frame(
    product_id = paste0("P", 1:12), # dk why paste0 is here and why not paste
    category = rep(c("Electronics", "Clothing", "Home"), each = 4), # these are three categories,
    base_price = c(
        runif(4, 200, 600), # the price of electronics
        runif(4, 20, 60), # the price of clothing
        runif(4, 50, 150) # the price of home
    )
)
regions <- c("North", "South", "East", "west") # these are the sectors in which sales occur
channels <- c("Online", "Store") # these are the channels through which sale occurs

generate_daily_sales <- function(date) {
    product <- products[sample(nrow(products), 1), ]
    month_factor <- ifelse(
        format(date, "%m") %in% c("11", "12"), 1.4, 1
    )

    # sso this is how you do if else in R
    weekday_factor <- ifelse(
        weekdays(date) %in% c("Saturday", "Sunday"), 1.2, 1
    )

    promotion <- sample(c("Yes", "No"), 1, prob = c(0.25, 0.75))
    promo_factor <- ifelse(promotion == "Yes", 1.5, 1)

    quantity <- round(
        rpois(1, lambda = 5 * month_factor * weekday_factor * promo_factor)
    )

    unit_price <- round(
        product$base_price * ifelse(promotion == "Yes", 0.85, 1),
        2
    )

    data.frame(
        date = date,
        order_id = paste0("ORD", sample(100000:999999, 1)),
        customer_id = paste0("C", sample(1:500, 1)),
        product_id = product$product_id,
        category = product$category,
        unit_price = unit_price,
        quantity = quantity,
        revenue = unit_price * quantity,
        region = sample(regions, 1),
        sales_channel = sample(channels, 1, prob = c(0.6, 0.4)),
        promotion = promotion
    )
}


sales_data <- do.call(
    rbind,
    lapply(dates, generate_daily_sales)
)
print(head(sales_data))

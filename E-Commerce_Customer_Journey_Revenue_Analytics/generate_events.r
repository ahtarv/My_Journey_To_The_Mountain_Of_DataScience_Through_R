set.seed(42)

customers <- read.csv("data/customers.csv")
products <- read.csv("data/products.csv")

events <- list()
event_id <- 1

for (i in 1:nrow(customers)) {
    customer <- customers[i, ]

    num_sessions <- sample(1:10, 1)

    for (s in 1:num_sessions) {
        product <- products[sample(nrow(products), 1), ]

        promo <- sample(
            c(0, 10, 20, 30), # these are the promo numbers
            1, # pick one promo value
            prob = c(0.6, 0.2, 0.15, 0.05) # probabilities for each promo level
        )

        view_date <- sample(
            seq.Date(
                from = as.Date(customer$signup_date),
                to = as.Date("2024-12-31"),
                by = "day"
            ),
            1
        )

        # view event
        events[[event_id]] <- data.frame(
            event_id = event_id,
            customer_id = customer$customer_id,
            event_date = view_date,
            event_type = "view",
            product_id = product$product_id,
            quantity = NA,
            discount_pct = promo,
            revenue = 0,
            profit = 0
        )
        event_id <- event_id + 1

        # Add to cart probability (Loyal customers add more often)
        add_prob <- ifelse(
            customer$customer_segment == "Loyal", 0.45,
            ifelse(customer$customer_segment == "Returning", 0.3, 0.18)
        )

        if (runif(1) < add_prob) {
            events[[event_id]] <- data.frame(
                event_id = event_id,
                customer_id = customer$customer_id,
                event_date = view_date,
                event_type = "add_to_cart", # was "event_tye" (typo)
                product_id = product$product_id,
                quantity = NA,
                discount_pct = promo,
                revenue = 0,
                profit = 0
            )
            event_id <- event_id + 1

            # Purchase probability
            buy_prob <- add_prob * 0.6

            if (runif(1) < buy_prob) {
                qty <- sample(1:3, 1)

                # Apply discount to get final price, then calculate revenue & profit
                discounted_price <- product$base_price * (1 - promo / 100) # was undefined variable "price"
                revenue <- round(discounted_price * qty, 2)
                profit <- round((discounted_price - product$cost) * qty, 2)

                events[[event_id]] <- data.frame(
                    event_id = event_id,
                    customer_id = customer$customer_id,
                    event_date = view_date,
                    event_type = "purchase",
                    product_id = product$product_id,
                    quantity = qty,
                    discount_pct = promo,
                    revenue = revenue,
                    profit = profit
                )
                event_id <- event_id + 1
            }
        }
    }
}

events_df <- do.call(rbind, events)
write.csv(events_df, "data/events.csv", row.names = FALSE)

cat("Total events generated:", nrow(events_df), "\n")
print(head(events_df))

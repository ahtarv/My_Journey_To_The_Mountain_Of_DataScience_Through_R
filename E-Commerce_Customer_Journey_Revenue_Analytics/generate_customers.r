set.seed(42)

num_customers <- 5000

customers <- data.frame(
    customer_id = paste0("C", sprintf("%05d", 1:num_customers)), # so now i am starting this project which is massive ngl, but it feels fun. also dont know what sprintf does. paste0 i remember using but not why
    signup_date = sample(seq.Date(from = as.Date("2023-01-01"), to = as.Date("2024-12-31"), by = "day"), num_customers, replace = TRUE),
    customer_segment = sample(
        c("New", "Returning", "Loyal"),
        num_customers,
        replace = TRUE,
        prob = c(0.6, 0.25, 0.15) # this is the probabilit of each thing, like new gets 60%, returning gets 25% and loyal gets 15%
    ),
    region = sample(
        c("North", "South", "East", "West"), # this is where we declare the regions
        num_customers, # here we are talking about the customer table
        replace = TRUE # so here we are going region wise, north south east west like that
    ),
    acquisition_channel = sample(
        c("Ads", "Organic", "Referral"),
        num_customers,
        replace = TRUE,
        prob = c(0.45, 0.4, 0.15)
    )
)

dir.create("data", showWarnings = FALSE)
write.csv(customers, "data/custmers.csv", row.names = FALSE)

head(customers)

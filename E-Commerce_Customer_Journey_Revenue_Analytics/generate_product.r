set.seed(42)

products <- data.frame(
    product_id = paste0("P", sprintf("%03d", 1:30)), # 1:30 gives 30 products, not 1.30 which was a decimal
    category = rep(
        c("Electronic", "Clothing", "Home"),
        each = 10
    ),
    base_price = c(
        runif(10, 300, 1200), # Electronics prices
        runif(10, 20, 120), # Clothing prices
        runif(10, 50, 400) # Home prices
    )
)

# Calculate cost as 50-75% of base price (i.e. the cost to us, so we profit the rest)
products$cost <- round(
    products$base_price * runif(nrow(products), 0.5, 0.75), # was nrow(product) - typo, missing 's'
    2
)

dir.create("data", showWarnings = FALSE)
write.csv(products, "data/products.csv", row.names = FALSE)
print(head(products))

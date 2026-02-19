set.seed(42)

num_days <- 730
dates <- seq.Date(
    from = as.Date("2023-01-01"),
    by = "day",
    length.out = num_days
)#this is the date generation function, generates date in the interval of one day


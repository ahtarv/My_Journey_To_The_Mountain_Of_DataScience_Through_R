library(dplyr)
library(lubridate)

events <- read.csv("data/events.csv")
customers <- read.csv("data/customers.csv")
products <- read.csv("data/products.csv")

events$event_date <- as.Date(events$event_date)

funnel_overall <- events %>%
    filter(event_type %in% c("view", "add_to_cart", "purchase")) %>%
    distinct(customer_id, event_type) %>%
    count(event_type) %>%
    mutate(
        conversion_rate = n / max(n)
    ) # so this is the funnel code where in we decide by event type like the distinct things like distinct customer_id, event_type and all, plus count(event_type)

print(funnel_overall)

events_with_segment <- events %>%
    left_join(customers, by = "customer_id") # ayee sql once again, like we left join with customers' csv

funnel_by_segment <- events_with_segment %>%
    filter(event_type %in% c("view", "add_to_cart", "purchase")) %>% # this is once again the categories
    distinct(customer_id, customer_segment, event_type) %>% # this is like distinct, cust_id, cust_segment, event_type
    group_by(customer_segment, event_type) %>% # then once again group by
    summarise(users = n(), .groups = "drop") %>% # then you summarise this shit
    group_by(customer_segment) %>% # then once again putting in group by
    mutate(
        conversion_rate = users / max(users)
    ) # this is the mutate thing, like we check the conversion rate and we change it

print(funnel_by_segment)

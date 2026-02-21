# install.packages("forecast") # already installed, commenting out to avoid CRAN mirror error in Rscript


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

revenue_ts <- ts(
    monthly_revenue$total_revenue,
    start = c(year(min(monthly_revenue$month)), month(min(monthly_revenue$month))),
    frequency = 12
) # this is the monthly data with yearly seasonality.


naive_model <- naive(revenue_ts, h = 6) # new territory, no idea what all this
arima_model <- auto.arima(revenue_ts, seasonal = TRUE)
arima_forecast <- forecast(arima_model, h = 6) # finally forecasting territory, though i dont any of this ngl
pdf("outputs/figures/revenue_forecast.pdf", width = 9, height = 6)

plot(
    arima_forecast,
    main = "6-Month Revenue Forecast (Seasonal ARIMA)", # aye last time we used lab, but this time we are directly using lab in this
    xlab = "Time",
    ylab = "Revenue"
)

lines(naive_model$mean, col = "red", lty = 2)
legend("topleft", legend = c("Seasonal ARIMA Forecast", "Naive Forecast"), col = c("blue", "red"), lty = c(1, 2), bty = "n") # no idea what this is this is legend sure but of what

dev.off()

# also save as PNG for README
png("outputs/figures/revenue_forecast.png", width = 900, height = 600)
plot(
    arima_forecast,
    main = "6-Month Revenue Forecast (Seasonal ARIMA)",
    xlab = "Time",
    ylab = "Revenue"
)
lines(naive_model$mean, col = "red", lty = 2)
legend("topleft", legend = c("Seasonal ARIMA Forecast", "Naive Forecast"), col = c("blue", "red"), lty = c(1, 2), bty = "n")
dev.off()

checkresiduals(arima_model)
print(revenue_ts)

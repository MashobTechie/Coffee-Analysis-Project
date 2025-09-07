# Load necessary libraries
library(dplyr)
library(ggplot2)
library(forecast)
library(tseries)

# Load the cleaned dataset
coffee_data <- read.csv("./Data/Coffee_Cleaned.csv")

# Ensure the Order.Date is in the correct format
# The format is year-month-day
coffee_data$Order.Date <- as.Date(coffee_data$Order.Date)

# Aggregate sales to a daily level
daily_sales <- coffee_data %>%
  group_by(Order.Date) %>%
  summarise(Total.Sales = sum(Sales)) %>%
  ungroup()

# Handle missing dates (where there were no sales)
# First, create a full sequence of dates.
# The 'from' and 'to' arguments must be valid dates.
# The issue is that your data might have NA values in the date column after initial cleaning, so we need to filter them out. # nolint: line_length_linter.
daily_sales <- daily_sales[!is.na(daily_sales$Order.Date), ]
full_date_range <- data.frame(Order.Date = seq(min(daily_sales$Order.Date), max(daily_sales$Order.Date), by = "day")) # nolint: line_length_linter.

# Join the full date range with your sales data
daily_sales <- left_join(full_date_range, daily_sales, by = "Order.Date")

# Replace any NA values with 0
daily_sales$Total.Sales[is.na(daily_sales$Total.Sales)] <- 0

# Check the new structure and look for any NA values
str(daily_sales)
colSums(is.na(daily_sales))

# Check for the last date in the dataset
last_date <- max(daily_sales$Order.Date)
print(paste("The last date in the dataset is:", last_date))

# Convert the data to a time series object
# The start date needs to be explicitly defined as the first date in your cleaned data. # nolint: line_length_linter.
# Frequency is 365 for daily data
start_date <- min(daily_sales$Order.Date)
sales_ts <- ts(daily_sales$Total.Sales, start = c(as.numeric(format(start_date, "%Y")), as.numeric(format(start_date, "%j"))), frequency = 365) # nolint: line_length_linter.

# Plot the time series to see the trend and seasonality
plot(sales_ts, main = "Total Daily Sales", xlab = "Date", ylab = "Sales")

# Decompose the time series to visualize trend, seasonality, and remainder
# This should now work correctly with the properly formatted time series object
sales_ts_decomp <- decompose(sales_ts)
plot(sales_ts_decomp)

# Fit an ARIMA model to the sales data
# auto.arima() automatically selects the best model
fit_model <- auto.arima(sales_ts)

# Use the model to forecast sales for the next 7 days
# The 'h' parameter specifies the number of periods to forecast
forecast_sales <- forecast(fit_model, h = 7)

# Print the forecast results
print(forecast_sales)

# Plot the forecast
plot(forecast_sales, main = "7-Day Sales Forecast")

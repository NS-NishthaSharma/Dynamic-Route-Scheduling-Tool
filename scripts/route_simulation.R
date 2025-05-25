library(ggplot2)
library(dplyr)

# Load data
data <- read.csv("data/sample_passenger_data.csv")

# Convert Time to POSIX time object
data$Time <- strptime(data$Time, format="%H:%M")

# Aggregate average load per stop
agg_data <- data %>%
  group_by(Stop_ID) %>%
  summarise(Avg_Load = mean(Passenger_Load))

# Simulate optimization (e.g., 15% reduction)
agg_data$Optimized_Load <- agg_data$Avg_Load * 0.85

# Plot original vs optimized
ggplot(agg_data, aes(x = factor(Stop_ID))) +
  geom_bar(aes(y = Avg_Load), stat = "identity", fill = "red", alpha = 0.6) +
  geom_bar(aes(y = Optimized_Load), stat = "identity", fill = "green", alpha = 0.6) +
  labs(title = "Passenger Load Before and After Optimization",
       x = "Stop ID",
       y = "Passenger Load")

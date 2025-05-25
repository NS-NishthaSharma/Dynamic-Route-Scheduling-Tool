import pandas as pd
import numpy as np

# Load the dataset
df = pd.read_csv("data/sample_passenger_data.csv")

# Convert Time column to datetime format
df['Time'] = pd.to_datetime(df['Time'], format='%H:%M')
df['Hour'] = df['Time'].dt.hour

# Group by Stop and Hour to calculate average load
summary = df.groupby(['Stop_ID', 'Hour'])['Passenger_Load'].mean().reset_index()
summary.rename(columns={'Passenger_Load': 'Avg_Passenger_Load'}, inplace=True)

# Identify bottlenecks (example threshold = 50)
summary['Bottleneck'] = summary['Avg_Passenger_Load'] > 50

# Save output as Excel for Power BI or further analysis
summary.to_excel("data/processed_schedule.xlsx", index=False)

print("✅ Processed schedule saved to 'data/processed_schedule.xlsx'")

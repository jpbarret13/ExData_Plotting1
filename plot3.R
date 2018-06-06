## This file is used to make plot 3 for the first peer graded assignment
## in Exploratory Data Analysis
library(data.table)
library(ggplot2)
library(scales)
library(tidyr)
library(ggthemes)

## Copy all data into a data frame and change Date column to "Date" format
all_data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
all_data$Date <- as.Date(as.character(all_data$Date), "%d/%m/%Y")

## Subset data to only include dates that are being used for this assignment
data_subset <- subset(all_data, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

## Add the date and time columns together in order to get one Date/Time variable
data_subset$DateTime <- paste(data_subset$Date, data_subset$Time, sep = " ")
data_subset$DateTime <- as.POSIXct(strptime(data_subset$DateTime, "%Y-%m-%d %H:%M:%S"))

## Changing columns and data to a numeric so it can be plotted as a time-series and
## then the data is plotted
data_subset$Global_active_power <- as.numeric(as.character(data_subset$Global_active_power))
data_subset$Sub_metering_1 <- as.numeric(as.character(data_subset$Sub_metering_1))
data_subset$Sub_metering_2 <- as.numeric(as.character(data_subset$Sub_metering_2))
data_subset$Sub_metering_3 <- as.numeric(as.character(data_subset$Sub_metering_3))

data_subset <- gather(data_subset, key, value, 7:9)
g <- ggplot(data_subset, aes( x = DateTime, y = value, color = key)) + geom_line() +
  scale_x_datetime(labels = date_format("%a"),breaks = date_breaks("1 day")) +
  xlab("") + ylab("Energy sub metering") + 
  theme_tufte() +
  theme(legend.position = c(.85, .85), legend.title = element_blank()) 

## Print the figure to a file
ggsave("plot3.png", width = 5, height = 5)
## This file is used to make plot 4 for the first peer graded assignment
## in Exploratory Data Analysis
library(data.table)
library(ggplot2)
library(scales)
library(tidyr)
library(cowplot)
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
data_subset$Voltage <- as.numeric(as.character(data_subset$Voltage))
data_subset$Global_reactive_power <- as.numeric(as.character(data_subset$Global_reactive_power))

## Gather sub metering variables into 1 key value pair to make the data tidy
data_subset <- gather(data_subset, key, value, 7:9)

## plots
g1 <- ggplot(data_subset, aes(DateTime, Global_active_power)) + geom_line() +xlab("") +
  ylab("Global Active Power (kilowatts)") +  scale_x_datetime(labels = date_format("%a"),
                                                              breaks = date_breaks("1 day"))

g2 <- ggplot(data_subset, aes(DateTime, Voltage)) + geom_line() + xlab("datetime") +
  scale_x_datetime(labels = date_format("%a"),breaks = date_breaks("1 day"))

g3 <- ggplot(data_subset, aes( x = DateTime, y = value, color = key)) + geom_line() +
  scale_x_datetime(labels = date_format("%a"),breaks = date_breaks("1 day")) +
  xlab("") + ylab("Energy sub metering") +
  theme(legend.position = c(.55, .9), legend.title = element_blank()) + 
  theme_tufte()

g4 <- ggplot(data_subset, aes(DateTime, Global_reactive_power)) + geom_line() +
  xlab("datetime") +
  scale_x_datetime(labels = date_format("%a"),breaks = date_breaks("1 day"))

g <- plot_grid(g1, g2, g3, g4, labels = "AUTO")

## Print the figure to a file
save_plot("plot4.png", g, ncol = 2, nrow = 2)
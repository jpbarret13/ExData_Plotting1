## This file is used to make plot 1 for the first peer graded assignment
## in Exploratory Data Analysis
library(data.table)

## Copy all data into a data frame and change Date column to "Date" format
all_data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
all_data$Date <- as.Date(as.character(all_data$Date), "%d/%m/%Y")

## Subset data to only include dates that are being used for this assignment
data_subset <- subset(all_data, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

## Changing column and data to a numeric so it can be plotted as a histogram and
## then the data is plotted
data_subset$Global_active_power <- as.numeric(as.character(data_subset$Global_active_power))
with(data_subset, hist(Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", 
                       ylab = "Frequency", main = "Global Active Power", 
                       cex.main = .75, cex.axis = .75, cex.lab = .75))

## Print the figure to a file
dev.copy(png, "plot1.png")
dev.off()
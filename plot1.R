library(sqldf)

# Read only the data from the dates 2007-02-01 and 2007-02-02
selecteddata <- read.csv.sql("household_power_consumption.txt", sql = "select * from file where Date in ('1/2/2007','2/2/2007')", sep = ";")

# Select the Global Active Power
gap <- selecteddata[, "Global_active_power"]

#Create png file with the required dimentions
png("plot1.png", width = 480, height = 480)

# Plot the histogram
hist(gap, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")

# Close the png file device
dev.off()
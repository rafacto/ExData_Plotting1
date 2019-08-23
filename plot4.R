library(sqldf)

# Changing time locale to English since I am from BR and the weekdays would appear in Portuguese
Sys.setlocale("LC_TIME", "English")

# Read only the data from the dates 2007-02-01 and 2007-02-02
selecteddata <- read.csv.sql("household_power_consumption.txt", sql = "select * from file where Date in ('1/2/2007','2/2/2007')", sep = ";")

# Select the Global Active Power
gap <- selecteddata[, "Global_active_power"]

# Select the Voltage
volt <- selecteddata[, "Voltage"]

# Select the Global Reactive Power
grp <- selecteddata[, "Global_reactive_power"]

#Concatenate date and time variables in one single time variable
fulltime <- paste(selecteddata$Date, selecteddata$Time)

# Convert the time variable to time class
time <- strptime(fulltime, "%d/%m/%Y %H:%M:%S")

# Select the 3 energy sub-metering variables
sub1 <- selecteddata[, "Sub_metering_1"]
sub2 <- selecteddata[, "Sub_metering_2"]
sub3 <- selecteddata[, "Sub_metering_3"]

# Create png file with the required dimentions
png("plot4.png", width = 480, height = 480)

# Set the layout (2 rows and 2 columns) for the multiple base plot
par(mfrow = c(2,2))

# Plot graph 1
plot(time, gap, type = "l", xlab = "", ylab = "Global Active Power")

#Plot graph 2
plot(time, volt, type = "l", xlab = "datetime", ylab = "Voltage")

# Plot graph 3
plot(time, sub1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(time, sub2, type = "l", col = "red")
lines(time, sub3, type = "l", col = "blue")

# Add legend to graph 3
legend("topright", bty = "n", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"))

# Plot graph 4
plot(time, grp, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

# Close the png file device
dev.off()
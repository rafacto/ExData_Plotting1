library(sqldf)

# Changing time locale to English since I am from BR and the weekdays would appear in Portuguese
Sys.setlocale("LC_TIME", "English")

# Read only the data from the dates 2007-02-01 and 2007-02-02
selecteddata <- read.csv.sql("household_power_consumption.txt", sql = "select * from file where Date in ('1/2/2007','2/2/2007')", sep = ";")

#Concatenate date and time variables in one single time variable
fulltime <- paste(selecteddata$Date, selecteddata$Time)

# Convert the time variable to time class
time <- strptime(fulltime, "%d/%m/%Y %H:%M:%S")

# Select the 3 energy sub-metering variables
sub1 <- selecteddata[, "Sub_metering_1"]
sub2 <- selecteddata[, "Sub_metering_2"]
sub3 <- selecteddata[, "Sub_metering_3"]

# Create png file with the required dimentions
png("plot3.png", width = 480, height = 480)

# Plot each energy sub-metering virable per time
plot(time, sub1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(time, sub2, type = "l", col = "red")
lines(time, sub3, type = "l", col = "blue")

# Add legend
legend("topright", lty = 1, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"))

# Close the png file device
dev.off()
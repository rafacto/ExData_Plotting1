library(sqldf)

# Changing time locale to English since I am from BR and the weekdays would appear in Portuguese
Sys.setlocale("LC_TIME", "English")

# Read only the data from the dates 2007-02-01 and 2007-02-02
selecteddata <- read.csv.sql("household_power_consumption.txt", sql = "select * from file where Date in ('1/2/2007','2/2/2007')", sep = ";")

#Concatenate date and time variables in one single time variable
fulltime <- paste(selecteddata$Date, selecteddata$Time)

# Convert the time variable to time class
time <- strptime(fulltime, "%d/%m/%Y %H:%M:%S")

# Select the Global Active Power
gap <- selecteddata[, "Global_active_power"]

# Create png file with the required dimentions
png("plot2.png", width = 480, height = 480)

# Plot a line graph
plot(time, gap, type = "l", xlab = "",ylab = "Global Active Power (kilowatts)")

# Close the png file device
dev.off()
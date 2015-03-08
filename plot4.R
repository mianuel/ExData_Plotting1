if("data.table" %in% rownames(installed.packages()) == FALSE) {
    install.packages("data.table")}
library(data.table)

# Read data from file in a datatable
electricData <- fread("household_power_consumption.txt", header=TRUE, sep=";",
                      colClasses="character", na="?")

# Zoom on two days
BeginDate <- "2007-02-01"
LastDate <- "2007-02-02"

# Change the dates' format
electricData$Date <- as.Date(electricData$Date, format="%d/%m/%Y")

# Get data of two days
electricData <- electricData[electricData$Date >= BeginDate & electricData$Date <= LastDate]

# Change the dates' format
electricData$DateTime <- paste(electricData$Date, electricData$Time)
DateTime <- strptime(electricData$DateTime, format = "%Y-%m-%d %H:%M:%S")

# Convert Global_active_power character to numeric
Global_active_power <- as.numeric(electricData$Global_active_power)
sub_Metering_1 <- as.numeric(electricData$Sub_metering_1)
sub_Metering_2 <- as.numeric(electricData$Sub_metering_2)
sub_Metering_3 <- as.numeric(electricData$Sub_metering_3)
Voltage <- as.numeric(electricData$Voltage)
Global_reactive_power <- as.numeric(electricData$Global_reactive_power)

# Open Graphic device
png(filename = "plot4.png",
    width = 480,
    height = 480,
    units = "px",
    pointsize = 12,
    bg = "white")

par(mfrow = c(2, 2))
# Create Plot
plot(DateTime, Global_active_power,
     type="l",
     xlab="", ylab="Global Active Power",
     cex=0.2)
plot(DateTime, Voltage, type="l",
     xlab="datetime")
plot(DateTime, sub_Metering_1, type="l",
     xlab="", ylab="Energy sub metering")
lines(DateTime, sub_Metering_2, type="l", col="red")
lines(DateTime, sub_Metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=, lwd=2.5, col=c("black", "red", "blue"), bty="n")
plot(DateTime, Global_reactive_power, type="l",
     xlab="datetime")
# Close Graphic Device
x <- dev.off()

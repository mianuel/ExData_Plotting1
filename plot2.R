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

# Open Graphic device
png(filename = "plot2.png",
    width = 480,
    height = 480,
    units = "px",
    pointsize = 12,
    bg = "white")

# Create Plot
plot(DateTime, Global_active_power,
     xlab = " ",
     ylab='Global Active Power (kilowatts)',
     type ="l",
     xaxt = "n")

# The following try to translate French days name to English day
# But those commands doesn't work !!!
EnglishDay = c("Thu", "Fri", "Sat")
axis(side=1, at=1:3, labels=EnglishDay)

# Close Graphic Device
x <- dev.off()

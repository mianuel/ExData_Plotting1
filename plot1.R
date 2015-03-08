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

# Convert Global_active_power character to numeric
electricData$Global_active_power <- as.numeric(electricData$Global_active_power)

# Open Graphic device
png(filename = "plot1.png", width = 480, height = 480, units = "px",
    pointsize = 12, bg = "white")

# Create Histogram
hist(electricData$Global_active_power,main='Global Active Power',
     xlab='Global Active Power (kilowatts)',col='red', xlim=c(0, 6),
     ylim=c(0, 1200))

# Close Graphic Device
x<-dev.off()

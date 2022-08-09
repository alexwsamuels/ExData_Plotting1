download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile="household_power_consumption.zip", method = "curl")
unzip("household_power_consumption.zip")

colclass <- c(rep("character",2), rep("numeric",7))
data <- read.table("household_power_consumption.txt", sep = ";", header=TRUE, 
                   nrows = 69516, na.strings = "?", colClasses = colclass)
data <- data[66637:69516,]
datetime <- mapply(function(x,y) paste(x,y), data[1], data[2])
datetime <- strptime(datetime, "%d/%m/%Y %H:%M:%S")
data <- cbind(data, datetime)


png(filename="plot1.png")

hist(data$Global_active_power, col="red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")

dev.off()

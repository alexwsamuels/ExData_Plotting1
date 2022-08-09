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


png(filename="plot4.png")
par(mfcol = c(2,2))

plot(data$datetime, data$Global_active_power, type = "l", xlab = "", 
     ylab = "Global Active Power (kilowatts)")

plot(data$datetime, data$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
points(data$datetime, data$Sub_metering_1, type="l", lty=1)
points(data$datetime, data$Sub_metering_2, type="l", lty=1, col="red")
points(data$datetime, data$Sub_metering_3, type="l", lty=1, col="blue")
legend("topright", lty=1, col=c("black", "red", "blue"), legend=names(data[7:9]))

with(data, plot(datetime, Voltage, type="l", lty=1))

with(data, plot(datetime, Global_reactive_power, type="l", lty=1))

dev.off()
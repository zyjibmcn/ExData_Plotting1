con <- file("household_power_consumption.txt", "r")

data_all <- read.table(con, header=T, sep=';', na.strings="?", check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
data_all$Date <- as.Date(data_all$Date, format="%d/%m/%Y")

data <- subset(data_all, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(data_all)

datetime <- paste(data$Date, data$Time)
data$Datetime <- as.POSIXct(datetime)

data$Global_active_power <- as.numeric(data$Global_active_power)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

plot(data$Datetime, data$Sub_metering_1, type="l", ylab="Energy Submetering", xlab="")
lines(data$Datetime, data$Sub_metering_2, type="l", col="red")
lines(data$Datetime, data$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))

## Saving to file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()

close(con)
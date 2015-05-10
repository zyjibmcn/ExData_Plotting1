con <- file("household_power_consumption.txt", "r")

data_all <- read.table(con, header=T, sep=';', na.strings="?", check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
data_all$Date <- as.Date(data_all$Date, format="%d/%m/%Y")

data <- subset(data_all, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(data_all)

datetime <- paste(data$Date, data$Time)
data$Datetime <- as.POSIXct(datetime)

data$Global_active_power <- as.numeric(data$Global_active_power)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)
data$Voltage <- as.numeric(data$Voltage)

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data, {
  plot(Global_active_power~Datetime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~Datetime, type="l",
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~Datetime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~Datetime, type="l",
       ylab="Global Rective Power (kilowatts)",xlab="")
})

## Saving to file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()

close(con)
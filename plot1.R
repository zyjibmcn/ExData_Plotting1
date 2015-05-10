con <- file("household_power_consumption.txt", "r")

data_all <- read.table(con, header=T, sep=';', na.strings="?", check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
data_all$Date <- as.Date(data_all$Date, format="%d/%m/%Y")

data <- subset(data_all, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(data_all)

datetime <- paste(data$Date, data$Time)
data$Datetime <- as.POSIXct(datetime)

data$Global_active_power <- as.numeric(data$Global_active_power)

## Plot 1
hist(data$Global_active_power, main="Global Active Power",
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
## Saving to file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()

close(con)
# Loading the data
setwd("C:/Users/sghue/Documents/R")
dsPower <- read.csv("./household_power_consumption.txt", header=T, sep=';', na.strings="?", 
               nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
dsPower$Date <- as.Date(dsPower$Date, format="%d/%m/%Y")
#-------------------------------------------------------------------------------------------
# Sub-setting the data
ssPower <- subset(dsPower, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(dsPower) ## Rlease memory
#-------------------------------------------------------------------------------------------
# Converting dates and times
dtPower <- paste(as.Date(ssPower$Date), ssPower$Time)
ssPower$Datetime <- as.POSIXct(dtPower)
#-------------------------------------------------------------------------------------------
# Plot 3
with(ssPower, {
    plot(Sub_metering_1~Datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
    lines(Sub_metering_2~Datetime,col='Red')
    lines(Sub_metering_3~Datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#-------------------------------------------------------------------------------------------
# Saving to file
dev.copy(png, file="./plot3.png", height=480, width=480)
dev.off()
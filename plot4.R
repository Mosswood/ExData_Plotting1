#Load data (assumes "household_power_consumption.txt" is in working directory)

fulldata <- read.table("household_power_consumption.txt",header=TRUE,na.strings="?",sep=";")

#Format date values and subset only dates me need

DataDate = transform(fulldata, DateTime = paste(Date,Time, sep=" "))
DataDate = transform(DataDate, DateTime = strptime(DataDate$DateTime,
                                                   "%d/%m/%Y %H:%M:%S"))
subdata <- subset(DataDate, DateTime > "2007-01-31 23:59:59" & DateTime < "2007-02-03 00:00:00")
days <- weekdays(subdata$DateTime,abbreviate = TRUE)
subdata2 <- cbind(subdata,days)

##Create plot and export file
png(filename="plot4.png", width=480, height=480)
par(mfrow=c(2,2))

plot(subdata2$DateTime, subdata2$Global_active_power,
     type="l", xlab="", ylab="Global Active Power")

plot(subdata2$DateTime, subdata2$Voltage,
     type="l", xlab="datetime", ylab="Voltage")

plot(subdata2$DateTime, subdata2[,7],type="l", xlab="", 
     ylab="Energy sub metering")
lines(subdata2$DateTime, subdata2[,8],type="l", xlab="", 
      ylab="Energy sub metering", col="red")
lines(subdata2$DateTime, subdata2[,9],type="l", xlab="", 
      ylab="Energy sub metering", col="blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       lty=c(1,1,1),col=c("black","red","blue"), bty ="n")

plot(subdata2$DateTime, subdata2$Global_reactive_power,
     type="l", xlab="datetime", ylab="Global_reactive_power", lwd="0.25")


dev.off()
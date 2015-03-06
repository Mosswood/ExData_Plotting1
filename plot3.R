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
png(filename="plot3.png", width=480, height=480)
plot(subdata2$DateTime, subdata2[,7],type="l", xlab="", 
     ylab="Energy sub metering")
lines(subdata2$DateTime, subdata2[,8],type="l", xlab="", 
      ylab="Energy sub metering", col="red")
lines(subdata2$DateTime, subdata2[,9],type="l", xlab="", 
      ylab="Energy sub metering", col="blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       lty=c(1,1,1),col=c("black","red","blue"))
dev.off()
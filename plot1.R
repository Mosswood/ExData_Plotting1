#Load data (assumes "household_power_consumption.txt" is in working directory)

fulldata <- read.table("household_power_consumption.txt",header=TRUE,na.strings="?",sep=";")

#Format date values and subset only dates me need

DataDate = transform(fulldata, DateTime = paste(Date,Time, sep=" "))
DataDate = transform(DataDate, DateTime = strptime(DataDate$DateTime, "%d/%m/%Y %H:%M:%S"))
subdata <- subset(DataDate, DateTime > "2007-01-31 23:59:59" & DateTime < "2007-02-03 00:00:00")

##Create plot and export file
png(filename="plot1.png", width=480, height=480)
hist(subdata$Global_active_power, main = " Global Active Power", col="red", xlab="Global Active Power (killowatts)")
dev.off()


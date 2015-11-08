if (!file.exists("data")) {
    dir.create("data")
}

##fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
##download.file(fileUrl, destfile = "./data/surveydata.csv", method = "wininet")
##list.files("./data")

library(data.table)

column_names <- fread("./data/household_power_consumption.txt",sep=";",nrows=1)


DF <- fread("./data/household_power_consumption.txt",sep=";",na.strings="?",
		colClasses = c("date","time","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),skip=66637 ,nrows=2880)

colnames(DF) <- colnames(column_names)

png(filename = "./plot4.png",height=480, width=480, bg="white")

par(mfcol = c(2,2))

### Draw plot 2

plot(strptime(paste(DF$Date, DF$Time),format="%d/%m/%Y %H:%M:%S")
	,DF$Global_active_power
	,xlab = ""
	,ylab = "Global Active Power (kilowatts)"
	,pch = ""
	,type = "o"
	)



### Draw plot 3

meter_range <- range(0,DF$Sub_metering_1, DF$Sub_metering_2, DF$Sub_metering_3)

	
plot(strptime(paste(DF$Date, DF$Time),format="%d/%m/%Y %H:%M:%S")
	,DF$Sub_metering_3
	,xlab = ""
	,ylab = "Energy sub metering"
	,type = "n"
	,ylim = meter_range
	)

points(strptime(paste(DF$Date, DF$Time),format="%d/%m/%Y %H:%M:%S")
	,DF$Sub_metering_1
	,pch = ""
	,type = "o"
	)

points(strptime(paste(DF$Date, DF$Time),format="%d/%m/%Y %H:%M:%S")
	,DF$Sub_metering_2
	,pch = ""
	,type = "o"
	,col = "red")

points(strptime(paste(DF$Date, DF$Time),format="%d/%m/%Y %H:%M:%S")
	,DF$Sub_metering_3
	,pch = ""
	,type = "o"
	,col = "blue")

legend("topright"
	,legend=colnames(DF)[7:9]
	,col = c("black","red","blue")
	,lty = 1
	,bty = "n")



## New 1

plot(strptime(paste(DF$Date, DF$Time),format="%d/%m/%Y %H:%M:%S")
	,DF$Voltage
	,xlab = "datetime"
	,ylab = "Voltage"
	,pch = ""
	,type = "o"
	)

## New 2

plot(strptime(paste(DF$Date, DF$Time),format="%d/%m/%Y %H:%M:%S")
	,DF$Global_reactive_power
	,xlab = "datetime"
	,ylab = colnames(DF)[4]
	,pch = ""
	,type = "o"
	)



dev.off()

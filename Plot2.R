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

png(filename = "./plot2.png",height=480, width=480, bg="white")
	
plot(strptime(paste(DF$Date, DF$Time),format="%d/%m/%Y %H:%M:%S")
	,DF$Global_active_power
	,xlab = ""
	,ylab = "Global Active Power (kilowatts)"
	,pch = ""
	,type = "o"
	)

dev.off()

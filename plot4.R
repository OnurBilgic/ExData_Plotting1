## 0. Clear history 
rm(list=ls())

## 1. Download file and unzip file
foldername<-"household_power_consumption.zip"
if (!file.exists(foldername)){
  file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file( file_url, foldername)
}  

if (!file.exists("household_power_consumption")) {  
  unzip(foldername) 
} 

## 2.read the data from file

hpowercons<-read.table("household_power_consumption.txt",header=TRUE,sep = ";",na.strings = "?")
## 2.5 set the local time to English

Sys.setlocale("LC_TIME", "English")
needfuldata<-transform(subset(hpowercons, Date=="1/2/2007"| Date =="2/2/2007"))

needfuldata$Date<-as.Date(needfuldata$Date,format='%d/%m/%Y')

datetime<-strptime(paste(needfuldata$Date,needfuldata$Time),format='%Y-%m-%d %H:%M:%S')

png("plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))
plot(datetime,needfuldata$Global_active_power,type="l",xlab ="",ylab ="Global Active Power")
plot(datetime,needfuldata$Voltage,type="l",ylab ="Voltage")
plot(datetime,needfuldata$Sub_metering_1,type="l",xlab ="",ylab ="Energy sub metering")

par(new=TRUE)

plot(datetime,needfuldata$Sub_metering_2,type="l",col="red",axes=FALSE,xlab ="",ylab ="Energy sub metering",ylim = c(0,30))

par(new=TRUE)

plot(datetime,needfuldata$Sub_metering_3,axes=FALSE, type="l",col="blue",xlab ="",ylab ="Energy sub metering",ylim = c(0,30))

legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),pch = c("-","-","-"),col=c("black","red","blue"))
plot(datetime,needfuldata$Global_reactive_power,type="l",ylab ="Global_reactive_power")

dev.off() 

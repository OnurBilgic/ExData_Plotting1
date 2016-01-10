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

datemerge<-strptime(paste(needfuldata$Date,needfuldata$Time),format='%Y-%m-%d %H:%M:%S')

##3. make a plot

with(needfuldata,plot(datemerge,Global_active_power,xlab = "",ylab = "Global active power (kilowatts",type="l"))

## 4. copy a png file

dev.copy(png, file = "plot2.png") ## Copy my plot to a PNG file
dev.off() ## Don't forget to close the PNG device!
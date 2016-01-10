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

hpowercons<-read.table("household_power_consumption.txt",header=TRUE,sep = ";")


needfuldata<-transform(subset(hpowercons, Date=="1/2/2007"| Date =="2/2/2007"))


## 3. make a histogram

hist(as.numeric(needfuldata$Global_active_power)/1000,col = "Red",xlab = "Global active power(kilowatts)",main = "Global active power")

## 4. copy to PNG file

dev.copy(png, file = "plot1.png") ## Copy plot to a PNG file
dev.off()
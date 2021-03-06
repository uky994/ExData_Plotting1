#CLEAR WORKSPACE
rm(list = ls())
 
#SET WORKING DIRECTORY
setwd("C:/Users/Dell - User/Desktop/jhu_data_sci/exData/week1")
 
#LOAD LIBRARIES
library(gridExtra)
library(ggplot2)
library(scales)
library(lubridate)
 
#READ IN TABLE
power<-read.table("household_power_consumption.txt", sep=';',colClasses=c
("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"), header=TRUE,na.strings='?')
 
#SUBSET DATA BETWEEN 2007-02-01 and 2007-02-02 AND KILL BIG DATA SET
power.sub<-power[which(power$Date=="1/2/2007" | power$Date=="2/2/2007"),]
rm(power)
 
#CONVERT DATE AND TIME FIELDS
power.sub$dt<-dmy_hms(paste(power.sub$Date, power.sub$Time, sep=" "))
power.sub$Date2<-dmy(power.sub$Date)
power.sub$Time2<-hms(power.sub$Time)
  
#TIME PLOT OF GLOBAL ACTIVE POWER
png(filename = "plot2.png",width = 504, height = 504, units = "px")
ggplot(power.sub, aes(dt, Global_active_power)) + geom_line() + xlab("") + ylab("Global Active Power (kilowatts)") + theme(panel.grid.minor=element_blank(),panel.grid.major=element_blank(),panel.background=element_rect(fill="white",color="black"),axis.text=element_text(color="black")) + scale_x_datetime(breaks=date_breaks("1 day"),labels = date_format("%a"))
dev.off()
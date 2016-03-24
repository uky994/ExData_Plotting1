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
  
#RESHAPE DATA FOR TIME PLOT OF SUBMETERING
sub1<-power.sub[c("dt","Sub_metering_1")]
sub1$group<-"Sub_metering_1"
colnames(sub1)[2]<-"sub_metering"
sub2<-power.sub[c("dt","Sub_metering_2")]
sub2$group<-"Sub_metering_2"
colnames(sub2)[2]<-"sub_metering"
sub3<-power.sub[c("dt","Sub_metering_3")]
sub3$group<-"Sub_metering_3"
colnames(sub3)[2]<-"sub_metering"
sub.meter<-rbind(sub1,sub2,sub3)
sub.meter$group<-as.factor(sub.meter$group)
 
#TIME PLOT OF SUBMETERING
png(filename = "plot3.png",width = 504, height = 504, units = "px")
ggplot(sub.meter,aes(x=dt,y=sub_metering,group=group, color=group)) + geom_line() + xlab("") + ylab("Energy sub metering") + theme(legend.title=element_blank(),panel.grid.minor=element_blank(),panel.grid.major=element_blank(),panel.background=element_rect(fill="white",color="black"),axis.text=element_text(color="black"),legend.position=c(1,1), legend.background = element_rect(color="black"), legend.justification = c(1, 1)) + scale_x_datetime(breaks=date_breaks("1 day"),labels = date_format("%a")) + scale_color_manual(values=c("black","red","blue"))
dev.off()
#plot 4
#<-------------------------

library(dplyr)
library(readr)
library(tidyverse)
library(xlsx)
library(sqldf)
library(data.table)
###############
library(openair)
library(lubridate)
# hist(x, main = "Top left")                   # Top left
# boxplot(x, main = "Bottom left")             # Bottom left
# plot(x, main = "Top right")                  # Top right
# pie(table(round(x)), main = "Bottom right")
setwd("C:/Users/marissa.j.arager/Desktop/Coursera R Course Materials/Exploratory Data Analysis") 

#load data 
exdata <- fread("household_power_consumption.txt")
exdata$Date <- as.data.frame(as.Date(exdata$Date, format = "%d/%m/%Y"))

feb_dates <- exdata[exdata$Date >= "2007-2-1" & exdata$Date <= "2007-2-2", ]
feb_dates$Global_active_power <- as.data.frame(as.numeric(feb_dates$Global_active_power))
feb_dates$Sub_metering_1 <- as.data.frame(as.numeric(feb_dates$Sub_metering_1))
feb_dates$Sub_metering_2 <- as.data.frame(as.numeric(feb_dates$Sub_metering_2))
#add new column to combine date/time and convert class to date/time
feb_dates$DateTime <- paste(feb_dates$Date, feb_dates$Time)
feb_dates$DateTime <- as.data.frame(as.POSIXct(feb_dates$DateTime))

png(file="Plot4.png")
par(mfrow=c(2,2))
#top left
plot(feb_dates$DateTime,feb_dates$Global_active_power, type ="l", ylab = "Global Active Power", xlab = "")

#top right
plot(feb_dates$DateTime,feb_dates$Voltage, type ="l", ylab = "Voltage", xlab = "datetime")

#bottom left (PLOT 3) 
plot(feb_dates$DateTime,feb_dates$Sub_metering_1, type ="l", ylab = "Energy Sub Metering", xlab = "", col = "black")
lines(feb_dates$DateTime,feb_dates$Sub_metering_2, type = "l", col = "red")
lines(feb_dates$DateTime,feb_dates$Sub_metering_3,  type = "l", col = "blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1,bty="n")

#bottom right
plot(feb_dates$DateTime,feb_dates$Global_reactive_power, type ="l", ylab = "Global_reactive_power", xlab = "datetime")

dev.off()

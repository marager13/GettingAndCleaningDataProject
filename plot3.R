#PLOT 3



#•	Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
#png(file="my_graph_2.png", res=600, width=480, height=480,

#	You may find it useful to convert the Date and Time variables to Date/Time classes in R using the 
#\color{red}{\verb|strptime()|}strptime()  and \color{red}{\verb|as.Date()|}as.Date() functions.

library(dplyr)
library(readr)
library(tidyverse)
library(xlsx)
library(sqldf)
library(data.table)
###############
library(openair)
library(lubridate)
library(scales)


setwd("C:/Users/marissa.j.arager/Desktop/Coursera R Course Materials/Exploratory Data Analysis") 

#load data 
exdata <- fread("household_power_consumption.txt")
exdata$Date <- as.data.frame(as.Date(exdata$Date, format = "%d/%m/%Y"))


feb_dates <- exdata[exdata$Date >= "2007-2-1" & exdata$Date <= "2007-2-2", ]
feb_dates$Global_active_power <- as.data.frame(as.numeric(feb_dates$Global_active_power))
#####feb_dates[,7:8] <- as.data.frame(as.numeric(feb_dates[c[,7:8]))
feb_dates$Sub_metering_1 <- as.data.frame(as.numeric(feb_dates$Sub_metering_1))
feb_dates$Sub_metering_2 <- as.data.frame(as.numeric(feb_dates$Sub_metering_2))


#add new column to combine date/time and convert class to date/time
feb_dates$DateTime <- paste(feb_dates$Date, feb_dates$Time)
feb_dates$DateTime <- as.data.frame(as.POSIXct(feb_dates$DateTime))



png(file="Plot3.png")

plot(feb_dates$DateTime,feb_dates$Sub_metering_1, type ="l", ylab = "Energy Sub Metering", xlab = "", col = "black")
lines(feb_dates$DateTime,feb_dates$Sub_metering_2, type = "l", col = "red")
lines(feb_dates$DateTime,feb_dates$Sub_metering_3,  type = "l", col = "blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1,bty=1)


dev.off()

# 
# The dataset has 2,075,259 rows and 9 columns.
# We will only be using data from the dates 2007-02-01 and 2007-02-02. One alternative is to read the data 
#from just those dates rather than reading in the entire dataset and subsetting to those dates.

#  Note that in this dataset missing values are coded as \color{red}{\verb|?|}?.

# Date: Date in format dd/mm/yyyy
# Time: time in format hh:mm:ss
# Global_active_power: household global minute-averaged active power (in kilowatt)
# Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
# Voltage: minute-averaged voltage (in volt)
# Global_intensity: household global minute-averaged current intensity (in ampere)
# Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
# Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
# Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.

#February 1st starts on row 66637

library(dplyr)
library(readr)
library(tidyverse)
library(xlsx)
library(sqldf)
library(data.table)
###############
library(openair)
library(lubridate)
#dowload and unzip dataset
setwd("C:/Users/marissa.j.arager/Desktop/Coursera R Course Materials/Exploratory Data Analysis") 
#download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","UCI_HAR_Dataset.zip")
unzip("exdata_data_household_power_consumption.zip")

exdata <- fread("household_power_consumption.txt")
exdata$Date <- as.data.frame(as.Date(exdata$Date, format = "%d/%m/%Y"))


feb_dates <- exdata[exdata$Date >= "2007-2-1" & exdata$Date <= "2007-2-2", ]
feb_dates$Global_active_power <- as.data.frame(as.numeric(feb_dates$Global_active_power))


#plot 1
png(file="Plot1.png")
hist(feb_dates$Global_active_power,col="red",xlab = "Global Active Power (kilowatts)", main = "Global Active Power") 
dev.off()


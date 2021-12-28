
# 1.	Merges the training and the test sets to create one data set.
# 2.	Extracts only the measurements on the mean and standard deviation for each measurement.
# 3.	Uses descriptive activity names to name the activities in the data set 
# 4.	Appropriately labels the data set with descriptive variable names.
# 5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
    

library(dplyr)
library(readr)
library(tidyverse)
library(xlsx)
library(sqldf)
library(data.table)


#dowload and unzip dataset
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","UCI_HAR_Dataset.zip")
unzip("UCI_HAR_Dataset.zip")

#read in tables and add labels
features <- fread("UCI HAR Dataset/features.txt", col.names = c("Num","Feature"))
activity_labels <- fread("UCI HAR Dataset/activity_labels.txt", col.names = c("Num", "Activity_Name"))
#read in test values
y_test <- fread("UCI HAR Dataset/test/y_test.txt", col.names = "Activity")
x_test <- fread("UCI HAR Dataset/test/x_test.txt", col.names = features$Feature)
subject_test <- fread("UCI HAR Dataset/test/subject_test.txt", col.names = "Subject")
#read in train values
y_train <- fread("UCI HAR Dataset/train/y_train.txt", col.names = "Activity")
x_train <- fread("UCI HAR Dataset/train/x_train.txt", col.names = features$Feature)
subject_train <- fread("UCI HAR Dataset/train/subject_train.txt", col.names = "Subject")
#bind x, y , and subject tables
x_combined <- rbind(x_train, x_test)
y_combined <- rbind(y_train, y_test)
subject_combined <- rbind(subject_train, subject_test)

#1. Merges the training and the test sets to create one data set.
merged_DF <- cbind(subject_combined,y_combined,x_combined)
og_merged_DF<- cbind(subject_combined,y_combined,x_combined)

# 2.	Extracts only the measurements on the mean and standard deviation for each measurement.
means_df <- cbind(merged_DF[,1],merged_DF[,2],select(merged_DF,contains("mean()")))
stdv_df <- cbind(merged_DF[,1],merged_DF[,2],select(merged_DF,contains("std()")))
combined_means_std <- cbind(means_df,stdv_df)

# 3.	Uses descriptive activity names to name the activities in the data set

       merged_DF$Activity[merged_DF[1:nrow(merged_DF),2]== 1]  <- "Walking" 
       merged_DF$Activity[merged_DF[1:nrow(merged_DF),2]== 2]  <- "Walking Upstairs" 
       merged_DF$Activity[merged_DF[1:nrow(merged_DF),2]== 3]  <- "Walking Downstairs" 
       merged_DF$Activity[merged_DF[1:nrow(merged_DF),2]== 4]  <- "Sitting" 
       merged_DF$Activity[merged_DF[1:nrow(merged_DF),2]== 5]  <- "Standing" 
       merged_DF$Activity[merged_DF[1:nrow(merged_DF),2]== 6]  <- "Laying" 


# 4.	Appropriately labels the data set with descriptive variable names.
       
 
 #Substitute Abbreviations with their corresponding full names
 colnames(merged_DF)<-gsub("Acc","Accelerometer",colnames(merged_DF), ignore.case = TRUE)
 colnames(merged_DF)<-gsub("Gyro","Gyroscope",colnames(merged_DF), ignore.case = TRUE)
 colnames(merged_DF)<-gsub("Mag","Magnitude",colnames(merged_DF), ignore.case = TRUE)
 colnames(merged_DF)<-gsub("Freq","Frequency",colnames(merged_DF), ignore.case = TRUE)
 colnames(merged_DF)<-gsub("BodyBody","Body",colnames(merged_DF), ignore.case = TRUE)
 colnames(merged_DF)<-gsub("^t","Time",colnames(merged_DF), ignore.case = TRUE)
 colnames(merged_DF)<-gsub("^f","Frequency",colnames(merged_DF), ignore.case = TRUE)
 colnames(merged_DF)<-gsub("tBody","TimeBody",colnames(merged_DF), ignore.case = TRUE)
 colnames(merged_DF)<-gsub("fBody","FrequencyBody",colnames(merged_DF), ignore.case = TRUE)
 
 #5.	From the data set in step 4, creates a second, independent tidy data set with the average 
 #of each variable for each activity and each subject.

 #create unique column names to remove duplicate names
 tidy_DF <- merged_DF
 tidy_DF_Names <- make.unique(colnames(merged_DF),".")
 colnames(tidy_DF)<-tidy_DF_Names


   Tidy_dataset <- tidy_DF %>% 
      group_by(Activity, Subject) %>%
      summarise(across(everything(), mean)) 
   
   write.table(Tidy_dataset, "Tidy_Dataset.txt", row.name=FALSE)
   
  
 

#Data processing script for Getting and Cleaning Data Course Project
#Author: Matt Quok
#Date: 06/21/2014

#Load Libraries
library(reshape2)

###############################################################################
#read all raw data files to data frames
###############################################################################
x_test <- read.table("UCI HAR Dataset/test/X_test.txt") #Data
y_test <- read.table("UCI HAR Dataset/test/y_test.txt") #Data Labels - Activity
sub_test <- read.table("UCI HAR Dataset/test/subject_test.txt") #subject number

x_train <- read.table("UCI HAR Dataset/train/X_train.txt") #data
y_train <- read.table("UCI HAR Dataset/train/y_train.txt") #data Labels - Activity
sub_train <- read.table("UCI HAR Dataset/train/subject_train.txt") #subject number

###############################################################################
#read descriptive files to to provide variable labels to columns and activities
###############################################################################

#Descriptor of the 6 activities observed
activity_labels <- read.table("UCI HAR Dataset//activity_labels.txt") 
#descriptor of the 561 types of data in the raw data set
features <- read.table("UCI HAR Dataset//features.txt")

###############################################################################
#bind subject ID and activity label to base train and test raw data sets
###############################################################################
train_set <- cbind(y_train,x_train) #bind activity label
train_set <- cbind(sub_train, train_set) #bind subject number
test_set <- cbind(y_test,x_test) #bind activity label
test_set <- cbind(sub_test, test_set) #bind subject number

###############################################################################
#Add column names to test and train datasets for merging 
###############################################################################
test_set_header <- c("subject","activity",as.character(features[[2]]))
names(test_set) <- test_set_header
train_set_header <- c("subject","activity",as.character(features[[2]]))
names(train_set) <- train_set_header

###############################################################################
#join test and train main data sets together in one data frame called full_x
###############################################################################
full_x <- rbind(test_set,train_set)

###############################################################################
#convert activity column into factor with labels from Codebook to provide 
#human-readable labels
###############################################################################
full_x$activity <- factor(full_x$activity,labels=activity_labels[[2]])
full_x$activity <- as.character(full_x$activity)

###############################################################################
#select only mean and standard deviation columns, or columns containing mean()
#and std() in column name, add more descriptive column names
###############################################################################
#save column #'s with either "mean()" or "std()" in the name
target <- c(c(1,2),grep("mean[()]",names(full_x)),grep("std[()]",names(full_x)))
sort(target) #sort to keep related columns together
mean_std_only <- full_x[, target] #subset full_x for mean and std columns
names(mean_std_only) <- c("subject.number","activity.type","Time.Domain.Body.Acceleration-mean-X-axis","Time.Domain.Body.Acceleration-mean-Y-axis",
                          "Time.Domain.Body.Acceleration-mean-Z-axis","Time.Domain.Gravity.Acceleration-mean-X-axis",
                          "Time.Domain.Gravity.Acceleration-mean-Y-axis","Time.Domain.Gravity.Acceleration-mean-Z-axis",
                          "Time.Domain.Body.AccelerationJerk-mean-X-axis","Time.Domain.Body.AccelerationJerk-mean-Y-axis",
                          "Time.Domain.Body.AccelerationJerk-mean-Z-axis","Time.Domain.BodyGyroscope-mean-X-axis",
                          "Time.Domain.BodyGyroscope-mean-Y-axis","Time.Domain.BodyGyroscope-mean-Z-axis",
                          "Time.Domain.BodyGyroscopeJerk-mean-X-axis","Time.Domain.BodyGyroscopeJerk-mean-Y-axis",
                          "Time.Domain.BodyGyroscopeJerk-mean-Z-axis","Time.Domain.Body.AccelerationMag-mean",
                          "Time.Domain.Gravity.AccelerationMag-mean","Time.Domain.Body.AccelerationJerkMag-mean",
                          "Time.Domain.BodyGyroscopeMag-mean","Time.Domain.BodyGyroscopeJerkMag-mean",
                          "Frequency.Domain.Body.Acceleration-mean-X-axis","Frequency.Domain.Body.Acceleration-mean-Y-axis",
                          "Frequency.Domain.Body.Acceleration-mean-Z-axis","Frequency.Domain.Body.AccelerationJerk-mean-X-axis",
                          "Frequency.Domain.Body.AccelerationJerk-mean-Y-axis","Frequency.Domain.Body.AccelerationJerk-mean-Z-axis",
                          "Frequency.Domain.Body.Gyroscope-mean-X-axis","Frequency.Domain.Body.Gyroscope-mean-Y-axis",
                          "Frequency.Domain.Body.Gyroscope-mean-Z-axis","Frequency.Domain.Body.AccelerationMag-mean",
                          "Frequency.Domain.Body.AccelerationJerkMag-mean","Frequency.Domain.Body.GyroscopeMag-mean",
                          "Frequency.Domain.Body.GyroscopeJerkMag-mean","Time.Domain.Body.Acceleration-Standard.Deviation-X-axis",
                          "Time.Domain.Body.Acceleration-Standard.Deviation-Y-axis","Time.Domain.Body.Acceleration-Standard.Deviation-Z-axis",
                          "Time.Domain.Gravity.Acceleration-Standard.Deviation-X-axis","Time.Domain.Gravity.Acceleration-Standard.Deviation-Y-axis",
                          "Time.Domain.Gravity.Acceleration-Standard.Deviation-Z-axis","Time.Domain.Body.AccelerationJerk-Standard.Deviation-X-axis",
                          "Time.Domain.Body.AccelerationJerk-Standard.Deviation-Y-axis","Time.Domain.Body.AccelerationJerk-Standard.Deviation-Z-axis",
                          "Time.Domain.BodyGyroscope-Standard.Deviation-X-axis","Time.Domain.BodyGyroscope-Standard.Deviation-Y-axis",
                          "Time.Domain.BodyGyroscope-Standard.Deviation-Z-axis","Time.Domain.BodyGyroscopeJerk-Standard.Deviation-X-axis",
                          "Time.Domain.BodyGyroscopeJerk-Standard.Deviation-Y-axis","Time.Domain.BodyGyroscopeJerk-Standard.Deviation-Z-axis",
                          "Time.Domain.Body.AccelerationMag-Standard.Deviation","Time.Domain.Gravity.AccelerationMag-Standard.Deviation",
                          "Time.Domain.Body.AccelerationJerkMag-Standard.Deviation","Time.Domain.BodyGyroscopeMag-Standard.Deviation",
                          "Time.Domain.BodyGyroscopeJerkMag-Standard.Deviation","Frequency.Domain.Body.Acceleration-Standard.Deviation-X-axis",
                          "Frequency.Domain.Body.Acceleration-Standard.Deviation-Y-axis","Frequency.Domain.Body.Acceleration-Standard.Deviation-Z-axis",
                          "Frequency.Domain.Body.AccelerationJerk-Standard.Deviation-X-axis","Frequency.Domain.Body.AccelerationJerk-Standard.Deviation-Y-axis",
                          "Frequency.Domain.Body.AccelerationJerk-Standard.Deviation-Z-axis","Frequency.Domain.Body.Gyroscope-Standard.Deviation-X-axis",
                          "Frequency.Domain.Body.Gyroscope-Standard.Deviation-Y-axis","Frequency.Domain.Body.Gyroscope-Standard.Deviation-Z-axis",
                          "Frequency.Domain.Body.AccelerationMag-Standard.Deviation","Frequency.Domain.Body.AccelerationJerkMag-Standard.Deviation",
                          "Frequency.Domain.Body.GyroscopeMag-Standard.Deviation","Frequency.Domain.Body.GyroscopeJerkMag-Standard.Deviation")

###############################################################################
#Use reshape2 package to first melt data with columns "Subject" and "activity"
#as id, and everything else as variables.  
#Cast molten data frame to calculate means of variables broken down by subject
#and then activity.
###############################################################################

molten_mean_std <- melt(mean_std_only,id=c("subject.number","activity.type"))
summary_data_frame <- dcast(molten_mean_std, subject.number + activity.type ~ variable, mean)

#Write tidy table to file
write.csv(summary_data_frame, "tidy_data.txt",row.names=FALSE)

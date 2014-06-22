#Codebook.md

##RAW Data Description and Study Design
Details about the UCI HAR dataset and how it was generated can be found at the link below:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

##PROCESSING STEPS, FROM RAW TO TIDY

####Raw Data Description
* "X_test.txt" and "X_train.txt", ("X" files) are flat files with data from the phone sensors. Each row is one observation during an activity type from one subject in the study, and each column is a different reading from the sensors during the activity. However, the data in these files do not have any data identifying either subject or activity type. 
*The "y_test.txt" and "y_train.txt" ("Y" files) contains one column identifying the activity type during an observation. This column directly associates the data in the rows of "X" files with an activity type. The activity types are identified with an integer from 1-6. 
* The "subject_test.txt" and "subject_train.txt" ("subject" files) contain one column of data identifying the subject during an observation. This column directly associates the data in the rows of "X" files with a subject. The subjects are identified with an integer from 1-30.
* The "activity_labels.txt" file contains definitions of the activity types in the "Y" files. Each integer in the "Y" files is associated with a activity description. This files contains 2 columns. Column one contains the integer labels 1-6. Column 2 contains a string with a human friendly description of the activity. Column 1 can be used as a key to identify the activity types in the "Y" files.
* The "features.txt" files contains 2 columns, one with a row label (integer, 1-561), and the second with a string description of the sensor reading. This file can be used as the key to the column headings of the "X" files.

#####Tidy Data Conversion Procedure
1. This script loads the "activity_labels.txt", "features.txt", "test/X_test.txt", "test/y_test.txt", "test/subject_test.txt", "train/X_train.txt", "train/y_train.txt", and"train/subject_train.txt" files into separate data frames. These separate data sets must be merged together to form a coherent data set that can be converted to tidy data.
2. The script binds activity and subject columns from the "subject" and "Y" files respectively to the "X" data frames to associate each row of sensor observations with a subject and activity type. The resulting data frames for the test and train data now contain a subject identifier in column 1, an activity identifier in column 2, and sensor data in subsequent columns.
3. The data frames from step do not contain column labels. Column 2 of the features.txt dataframe is converted to character vector and concatenated to a character vectow containing c("subject, "activity") to create a character vector of column headings for the data frames in step 2. These vectors are then defined as the column headings. At this point, the data frames now contain subject, activity, sensor data, and have human friendly column headings.
4. The test and train datasets from step 3 are concatenated together by rows (rbind) to create one large dataset. This works as data columns are identical in both sets. The resulting single data frame contains both test and train data with subject, activity, and sensor data.
4. The codebook of the UCI HAR Dataset defines data containing either a mean or standard deviation as having the strings "mean()" and "std()" in the colmn heading. The script selects only columns containing the strings "mean()" and "std()" in the column headers to create a new dataframe with only the relevant data which reduces the data frame from 563 columns to 68. Expanded column headers are applied to make the data more readable.
5. The reshape2 library is used to melt the dataframe from step 4 using subject ID and activity type as ID's. All other columns are identified as variables in the melt() function. At this point, each row is an observation containing a subject id, activity type, and sensor data. For each subject/activity type there are multiple readings of each sensor data variable. 
6. The mean of the multiple sensor readings for each subject/activity must be calculated. To do this, the molten data rame is the cast as a data frame ordered by subject ID, then activity type, and finally variable. Mean is the function applied in the cast() function to the data.
7. The resulting dataframe from the cast function in step 6 contains averages of the mean and standard deviation variables broken down by subject and activity type. This dataframe is written to a csv file called "tidy_data.txt" in the working directory of R. Resulting data is a "wide" tidy table where each row is an observation of a test subject performing one of six activities. This format can be easily reshaped for various analysis in R or imported into spreadsheet software.

##TIDY DATA FORMAT

Week 1 lecture "Components of Tidy Data" and Wickham, "Tidy Data" define tidy data as meeting three criteria.

1. Each variable you measure should be in one column.
2. Each different observation of that variable should be in a different row.
3. There should be one table for each "kind" of variable.

The resulting data file from the run_analysis.R script meets all criteria in the above definition of tidy data. Variables are ordered in columns. These variables are subject, activity type, and sensor readings. Each different observation is defined as the sensor data from one subject during one activity type. Each row in the output of run_analysis.R contains the subject identity, the type of activity during the observation, and the mean of the sensor data during that particular activity from a that specific subject. The data is formatted as follows:

Subject | Activity   | Sensor Data 1... |
-------- | ----------  | --------------- |
   1  |   WALKING   |   0.34343 |
   1 | SITTING   |   0.00222 |
   2 | WALKING	|  0.23944 |
   2 | SITTING	|  0.00202 |

 The data in this format can be easily imported and manipulated in either R or spreadsheets for further analysis.
 
##VARIABLE DEFINITIONS

See "features.info_txt" in the raw dataset for additional information on all variables except subject.number and activity.type. Names in "feature_info.txt" were expanded in the "tidy_data.txt" output as follows for additional readability:

* "Acc" was expanded to Acceleration
* "t" was expanded to Time.Domain
* "f" was expanded to Frequency.Domain
* "gryo" was expanded to Gyroscope
* X,Y,Z were expanded to X-Axis, Y-Axis, and Z-Axis respectively

For example, "Time.Domain.Body.Acceleration" in the original dataset was expanded to "Time.Domain.Body.Acceleration-mean-Y-axis" for additional readability.

###subject.number
Data Type: int
Subject Indentifier Number, 1-30

###activity.type
Data Type: String
Activity Type, one of six types below
	WALKING
	WALKING_UPSTAIRS
	WALKING_DOWNSTAIRS
	SITTING
	STANDING
	LAYING
	
###Time.Domain.Body.Acceleration-mean-X-axis
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Time.Domain.Body.Acceleration-mean-Y-axis
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Time.Domain.Body.Acceleration-mean-Z-axis
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Time.Domain.Gravity.Acceleration-mean-X-axis
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Time.Domain.Gravity.Acceleration-mean-Y-axis
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Time.Domain.Gravity.Acceleration-mean-Z-axis
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Time.Domain.Body.AccelerationJerk-mean-X-axis
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Time.Domain.Body.AccelerationJerk-mean-Y-axis
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Time.Domain.Body.AccelerationJerk-mean-Z-axis
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Time.Domain.BodyGyroscope-mean-X-axis
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Time.Domain.BodyGyroscope-mean-Y-axis
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Time.Domain.BodyGyroscope-mean-Z-axis
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Time.Domain.BodyGyroscopeJerk-mean-X-axis
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Time.Domain.BodyGyroscopeJerk-mean-Y-axis
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Time.Domain.BodyGyroscopeJerk-mean-Z-axis
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Time.Domain.Body.AccelerationMag-mean
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Time.Domain.Gravity.AccelerationMag-mean
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Time.Domain.Body.AccelerationJerkMag-mean
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Time.Domain.BodyGyroscopeMag-mean
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Time.Domain.BodyGyroscopeJerkMag-mean
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Frequency.Domain.Body.Acceleration-mean-X-axis
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Frequency.Domain.Body.Acceleration-mean-Y-axis
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Frequency.Domain.Body.Acceleration-mean-Z-axis
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Frequency.Domain.Body.AccelerationJerk-mean-X-axis
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Frequency.Domain.Body.AccelerationJerk-mean-Y-axis
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Frequency.Domain.Body.AccelerationJerk-mean-Z-axis
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Frequency.Domain.Body.Gyroscope-mean-X-axis
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Frequency.Domain.Body.Gyroscope-mean-Y-axis
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Frequency.Domain.Body.Gyroscope-mean-Z-axis
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Frequency.Domain.Body.AccelerationMag-mean
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Frequency.Domain.Body.AccelerationJerkMag-mean
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Frequency.Domain.Body.GyroscopeMag-mean
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Frequency.Domain.Body.GyroscopeJerkMag-mean
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Time.Domain.Body.Acceleration-Standard.Deviation-X-axis
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Time.Domain.Body.Acceleration-Standard.Deviation-Y-axis
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Time.Domain.Body.Acceleration-Standard.Deviation-Z-axis
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Time.Domain.Gravity.Acceleration-Standard.Deviation-X-axis
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Time.Domain.Gravity.Acceleration-Standard.Deviation-Y-axis
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Time.Domain.Gravity.Acceleration-Standard.Deviation-Z-axis
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Time.Domain.Body.AccelerationJerk-Standard.Deviation-X-axis
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Time.Domain.Body.AccelerationJerk-Standard.Deviation-Y-axis
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Time.Domain.Body.AccelerationJerk-Standard.Deviation-Z-axis
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Time.Domain.BodyGyroscope-Standard.Deviation-X-axis
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Time.Domain.BodyGyroscope-Standard.Deviation-Y-axis
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Time.Domain.BodyGyroscope-Standard.Deviation-Z-axis
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Time.Domain.BodyGyroscopeJerk-Standard.Deviation-X-axis
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Time.Domain.BodyGyroscopeJerk-Standard.Deviation-Y-axis
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Time.Domain.BodyGyroscopeJerk-Standard.Deviation-Z-axis
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Time.Domain.Body.AccelerationMag-Standard.Deviation
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Time.Domain.Gravity.AccelerationMag-Standard.Deviation
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Time.Domain.Body.AccelerationJerkMag-Standard.Deviation
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Time.Domain.BodyGyroscopeMag-Standard.Deviation
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Time.Domain.BodyGyroscopeJerkMag-Standard.Deviation
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Frequency.Domain.Body.Acceleration-Standard.Deviation-X-axis
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Frequency.Domain.Body.Acceleration-Standard.Deviation-Y-axis
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Frequency.Domain.Body.Acceleration-Standard.Deviation-Z-axis
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Frequency.Domain.Body.AccelerationJerk-Standard.Deviation-X-axis
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Frequency.Domain.Body.AccelerationJerk-Standard.Deviation-Y-axis
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Frequency.Domain.Body.AccelerationJerk-Standard.Deviation-Z-axis
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Frequency.Domain.Body.Gyroscope-Standard.Deviation-X-axis
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Frequency.Domain.Body.Gyroscope-Standard.Deviation-Y-axis
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Frequency.Domain.Body.Gyroscope-Standard.Deviation-Z-axis
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Frequency.Domain.Body.AccelerationMag-Standard.Deviation
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Frequency.Domain.Body.AccelerationJerkMag-Standard.Deviation
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Frequency.Domain.Body.GyroscopeMag-Standard.Deviation
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.

###Frequency.Domain.Body.GyroscopeJerkMag-Standard.Deviation
Data Type: Numeric
Mean of all sensor readings as defined in variable title from one subject during one activity. Refer to "features_info.txt" in raw data folder  for more information.


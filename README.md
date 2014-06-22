CleaningDataCourseProject
=========================
###Files
* run_analysis.R - Takes UCI Raw Dataset and converts it to a Tidy Dataset in csv format.

###Usage
UCI data must be in the "UCI HAR Dataset" folder in R's working directoy. Original file structure of .zip directory must be maintained. Users run the run_analysis.R script. The script works as follows:

1. This script loads the activity_labels.txt, features.txt, "test/X_test.txt", "test/y_test.txt", "test/subject_test.txt", "train/X_test.txt", "train/y_test.txt", and "train/subject_test.txt" files into separate data frames. 
2. The script binds subject and acivity columns from the y_.txt and subject_.txt files to the test and train datasets to identify each set of observations.
3. The features.txt file is converted to column headers for the test and train dataset.
4. The test and train datasets are concatenated together to create one large dataset. This works as data columns are identical in both sets.
4. Script selects only columns containing mean() and std() creates a new dataframe with selected data. More descriptive column haeders are also applied.
5. The reshape2 library is used to melt the dataframe with subject number and acivity type as ID's. All other columns are variables. The molten data rame is the cast as a data frame using subject number + activity type, then variable, and mean is the function applied.
6. The resulting casted dataframe contains averages of the mean and standard deviation variables broken down by subject and activity type. THis dataframe is written to a csv file called "tidy_data.txt". Resulting data is a "wide" tidy table where each row is an observation of a test subject performing one of six activities. This format can be easily reshaped for various analysis in R or imported into spreadsheet software.


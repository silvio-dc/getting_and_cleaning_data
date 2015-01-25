README
=======

Course project "Getting and cleaning data - coursera"
-----------------------------------------------------

Load the raw data from 
[link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
extract it, and put the "run_analysis.R" file in one folder with the folder "test" and "train".

The R-script will read in the files "subjects_test","X_test" and "y_test" and the corresponding
files from the "train" folder.
It will put the train and test data together, extract the variables
which contains the string "mean()" or "std()" in the features.txt file.
The activity-label will be replaced with more descriptive text.

In the end, it will output a table with the average of each measurement
for each activity and each subject.

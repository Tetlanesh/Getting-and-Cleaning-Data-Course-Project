Getting-and-Cleaning-Data-Course-Project
========================================

This repository contains script "run_analisys.R" that is used to transform data for samsung accelerometer experiment into tidy for as requested by project description:

    You should create one R script called run_analysis.R that does the following. 
    Merges the training and the test sets to create one data set.
    Extracts only the measurements on the mean and standard deviation for each measurement. 
    Uses descriptive activity names to name the activities in the data set
    Appropriately labels the data set with descriptive variable names. 
    From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### Requirments:
libraries:

    dplyr

R version (should work on earlier, but it was tested on provided below):

    R version 3.1.2 (2014-10-31) 

Data for analisys:

    Script is based on assumtpion that data for analysis are in workdir in folder:
    - UCI HAR Dataset
    
    Files can be ibtained at following location:
    https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
    unzip the file into Your working directory
    
    file needed and their location:
    UCI HAR Dataset/activity_labels.txt
    UCI HAR Dataset/features.txt
    UCI HAR Dataset/test/X_test.txt
    UCI HAR Dataset/test/y_test.txt
    UCI HAR Dataset/test/subject_test.txt
    UCI HAR Dataset/train/X_train.txt
    UCI HAR Dataset/train/y_train.txt
    UCI HAR Dataset/train/subject_train.txt

    Role each file have in obtaining file is best visualized using diagram made by "David Hood" on course project forum:
    https://class.coursera.org/getdata-016/forum/thread?thread_id=50#comment-333

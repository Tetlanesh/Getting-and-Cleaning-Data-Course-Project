Getting-and-Cleaning-Data-Course-Project
========================================

This repository contains script "run_analisys.R" that is used to transform data for samsung accelerometer experiment into tidy for as requested by project description:

    You should create one R script called run_analysis.R that does the following. 
    1. Merges the training and the test sets to create one data set.
    2. Extracts only the measurements on the mean and standard deviation for each measurement. 
    3. Uses descriptive activity names to name the activities in the data set
    4. Appropriately labels the data set with descriptive variable names. 
    5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### Requirments:
libraries:

    dplyr

R version (should work on earlier, but it was tested on provided below):

    R version 3.1.2 (2014-10-31) 

Data for analisys:

    Script is based on assumtpion that data for analysis are in workdir in folder:
    - UCI HAR Dataset
    
    Files can be obtained at following location:
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

    Role each file have in obtaining final data set is best visualized using diagram made by "David Hood" on course project forum:
    https://class.coursera.org/getdata-016/forum/thread?thread_id=50#comment-333

 
### Outcome of the script

results of the script are two datasets:
 - samsung - containing 10 299 rows and 68 columns, 66 of which are features and two last being subject code (id of a subject) and a factor of activity label (walking, laying, etc...)
 - final_tidy - fily that needs to be submited for the course to be complete. Contains 180 rows (30 subjects x 6 activities) and 68 columns (again 66 features + subjects and activities). Every row contrains subject number, activity label and mean() values for each of 66 features

final_tidy is wide tidy format, w have each row containing single subject doing single type of activity and we have each separate type of measurment (feature) as separate column

Also as final action the script will save "final_tidy" dataset into a tidy_data_set.txt file in your working directory
 
### Script breakdown

this is a short breakdown of what this script do to initial data files and how it transform it into final data sets. This is also included in the script file itself as a coments on a per line basis explaining each action. In here its more of a broad explenation of steps:

 - reads into variable features file to obtain list of all features
 - filters out the list of features leaving only those containing mean() or std() in their name - resulting in 66 features
 - clearing out the names of features, removing illegal characters (brackets and -), removing duplicated words that are errors (BodyBody)
 - changing initial f|t character into freq_ | time_ strings so its more clear what each feature represent on first glance
 - reads into variable activity labels file so we have a list of all 6 activities with coresponding id
 - reads in main test file (x_test) and keep only columns coresponding to features we chose (using our 66 long list of features)
 - reads in subject and activity file for test data set (y_test, subject_test) and cbinds it into main test data set
 - merges test data set with names of activietes
 - rearanges columns to make it more readable
 - reads in main training file (x_training) and keep only columns coresponding to features we chose (using our 66 long list of features)
 - reads in subject and activity file for training data set (y_training, subject_training) and cbinds it into main training data set
 - merges training data set with names of activietes
 - rearanges columns to make it more readable
 - rbinds both: test and training data sets into one big samsung data set containing all rows
 - removes redundant activity code column as we already joined in activity label
 - we set the grouping mode (dplyr library) on subject and activity
 - calculates mean values for each group of Subject / Activity / Feature
 - stores the final tidy set as a text file in working directory

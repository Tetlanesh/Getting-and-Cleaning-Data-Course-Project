#getting list of all features from working directory starting point
features<-read.table(file = "UCI HAR Dataset/features.txt")

#keeping only features of mean() and std()
#there is an argument that features like meanfreq() also count as mean, but if we look at the features definition it clearly is difrent function and assingment cealry states
#that we should take only mean and standard deviation and those two are listed as mean() and std() in features_info.txt

featuresstdmean<-features[grep('mean\\(\\)|std\\(\\)', features$V2),]
rm(features) #clearing memory 

#Lets change the names of features variables to be more descriptive and remove unneded and harmfull character (-()) and so on
featuresstdmean$V2<-gsub("\\(\\)", "", featuresstdmean$V2) #removing curly brackets
featuresstdmean$V2<-gsub("-", "_", featuresstdmean$V2) # changing dashes to undescore
featuresstdmean$V2<-gsub("^t", "time_", featuresstdmean$V2) #changing starting t to time_
featuresstdmean$V2<-gsub("^f", "freq_", featuresstdmean$V2) # and f to freq_
featuresstdmean$V2<-gsub("BodyBody", "Body", featuresstdmean$V2) #removing repeated instance of Body in names (BodyBody)

#reading in the list of activities to be used later for joining with actuall activities recorded

activities<-read.table(file = "UCI HAR Dataset/activity_labels.txt")
names(activities)<-c("Activity_code","Activity_description")

#starting with test data set we take the x_test file and extract colums that match variables that we selected and than add subject and activity info from subject_ and y_ files

####### TEST DATA EXTRACTION

testbig<-read.table(file = "UCI HAR Dataset/test/X_test.txt")
testsmall<-testbig[featuresstdmean$V1] #by providing vector of numbers (and $V1 contains column numbers from features list) we can select column numbers coresponding to the ones we wat

rm(testbig) #clearing memory

names(testsmall)<-featuresstdmean$V2 #adding names to the set

# reading in list of subject and activities
testsub<-read.table(file = "UCI HAR Dataset/test/subject_test.txt")
testact<-read.table(file = "UCI HAR Dataset/test/y_test.txt")

names(testsub)<-c("Subject_code") #adding name to column
names(testact)<-c("Activity_code") #adding name to column

#now we cbind those data together to get complete TEST set

test_final<-cbind(testsub,testact,testsmall) #joining by columns with subject and activity in the front
test_final<-merge(test_final, activities, by = 'Activity_code') #merging description of activity with the main set
test_final<-test_final[,c(2,1,69,3:68)] # reorder kolumns, so that it starts with: subject, activity code, activity description, and then list of all features

rm(testact,testsub,testsmall) #removing needles variables from memory


####### TRAINING DATA EXTRACTION - repeating above for training set

trainbig<-read.table(file = "UCI HAR Dataset/train/X_train.txt")
trainsmall<-trainbig[featuresstdmean$V1] #by providing vector of numbers (and $V1 contains column numbers from features list) we can select column numbers coresponding to the ones we wat

rm(trainbig) #clearing memory

names(trainsmall)<-featuresstdmean$V2 #adding names to the set

# reading in list of subject and activities
trainsub<-read.table(file = "UCI HAR Dataset/train/subject_train.txt")
trainact<-read.table(file = "UCI HAR Dataset/train/y_train.txt")

names(trainsub)<-c("Subject_code") #adding name to column
names(trainact)<-c("Activity_code") #adding name to column

#now we cbind those data together to get complete TEST set

train_final<-cbind(trainsub,trainact,trainsmall) #joining by columns with subject and activity in the front
train_final<-merge(train_final, activities, by = 'Activity_code') #merging description of activity with the main set
train_final<-train_final[,c(2,1,69,3:68)] # reorder kolumns, so that it starts with: subject, activity code, activity description, and then list of all features

rm(trainact,trainsub,trainsmall) #removing needles variables from memory

######### Joining TEST and TRAIN sets together via rbind

samsung<-rbind(test_final,train_final)
rm(test_final,train_final) #and again removing un-needed variables from memory

rm(activities,featuresstdmean) #removing no longer used variables from memory

library(dplyr) # You need to have dplyr instaled

samsung <- tbl_df(samsung) # we change regular data frame to sata frame table from dplyr package

#we have one redundant colun - activity_code, lets remove it.
samsung<-select(samsung,-Activity_code)


####
#### WE NOW HAVE SET THAT SATISFIES REQUIRMENTS OF POINT 1 TROUGH 4, NOW WE NEED TO MAKE SEPARATE TIDY DATA SET WITH MEANS OF OUR VARIABLES
####

#now we have to group our data set by subject and activity
samsung<-group_by(samsung,Subject_code, Activity_description)

#and calculate mean of each feature for each pair of subject and activity
final_tidy<-summarise_each(samsung, funs(mean))

### resulting in 180 x 68 data frame (30 subjects times 6 activities gives 180 rows)

###finally we store result in a file to be uploaded for peer review
write.table(final_tidy,file = "tidy_data_set.txt",row.names = FALSE)


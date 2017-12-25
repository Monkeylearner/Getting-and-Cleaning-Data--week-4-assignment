
library (plyr)
library (dplyr)
# read data and label the dataset with descriptive variable names 
feature<-read.table("./UCI HAR Dataset/features.txt")
feature<-feature[,2]
X_test<-read.table("./UCI HAR Dataset/test/X_test.txt",col.names=feature)
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt",col.names="subject identity")
y_test<-read.table("./UCI HAR Dataset/test/y_test.txt",col.names = "activity identity")
X_train<-read.table("./UCI HAR Dataset/train/X_train.txt",col.names=feature)
subject_trani<-read.table("./UCI HAR Dataset/train/subject_train.txt",col.names="subject identity")
y_train<-read.table("./UCI HAR Dataset/train/y_train.txt",col.names = "activity identity")
# select column with "sd", "mean" or "Mean" in test data
X_test<-read.table("./UCI HAR Dataset/test/X_test.txt",col.names=feature)
X_test_select<-select(X_test,contains("std"),contains("mean"),contains("Mean"))
X_train<-read.table("./UCI HAR Dataset/train/X_train.txt",col.names=feature)
X_train_select<-select(X_train,contains("std"),contains("mean"),cdentontains("Mean"))
# Add activity identity and subject identity with the selected dataset 
testData_select<-data.frame(X_test_select,y_test,subject_test)
trainData_select<-data.frame(X_train_select,y_train,subject_train)
# combine test data and train data
Data_select<-rbind(testData_select,trainData_select)
# add descriptive activity content to the combined data
activity<-read.table("./UCI HAR Dataset/activity_labels.txt",col.names=c("activity identity","activity_content"))
tidy_Data<-merge(Data_select,activity,"activity.identity")
# calculate the average of the independent tidy data set for each activity ad each subject
tidy_Data<-group_by(tidy_Data,subject.identity,activity_content)
tidy_Data<-summarize_each(tidy_Data,funs(mean))
tidy_Data<-select(tidy_Data,-activity.identity)
write.table(tidy_Data,file="tidy_Data.txt",row.names=FALSE, col.names=names(tidy_Data),sep=" ")

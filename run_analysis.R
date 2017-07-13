#Merges the training and the test sets to create one data set.
#1. Read the train files
trainx <- read.csv("UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)
trainy <- read.csv("UCI HAR Dataset/train/Y_train.txt", sep="", header=FALSE)
train_sub <- read.csv("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)
train <- data.frame(trainx,trainy,train_sub)

#2. Read the test files
testx <- read.csv("UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)
testy <- read.csv("UCI HAR Dataset/test/Y_test.txt", sep="", header=FALSE)
test_sub <- read.csv("UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)
test <- data.frame(testx,testy,test_sub)

#3. Create a single data set from both
joined <- rbind(train, test)

# get feature names & standardise them, labeling the data set with the appropriate names
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] = gsub('-mean', 'Mean', features[,2])
features[,2] = gsub('-std', 'Std', features[,2])
features[,2] = gsub('[-()]', '', features[,2])

colnames <- c(as.vector(features[,2]),"activity","subject")
colnames(joined)<- colnames

#4.Extracts only the measurements on the mean and standard deviation for each measurement.
relevantCols <- c(grep(".*Mean.*|.*Std.*", features[,2],val=TRUE),"activity","subject")
relevantDS <- joined[,relevantCols]

#Get Activity Names
activityLabels <- read.csv("UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)
relevantDS$activity <-factor(relevantDS$activity,levels=activityLabels[,1], labels=activityLabels[,2])

#merge subject & activity to single colum
relevantDS$subject_activity <- paste(relevantDS$subject, relevantDS$activity,setp="_")
                            
#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

tidyDS <- aggregate(subset(relevantDS,select=-c(activity,subject,subject_activity)),by=list(subject_activity=relevantDS$subject_activity),FUN="mean")
#SAVE DS 
write.table(tidyDS, file="tidy.txt", row.names = FALSE)
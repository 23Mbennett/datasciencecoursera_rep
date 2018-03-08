library(plyr)
library(reshape2)

#Create directory & Download files
dir.create("Getting&CleaningProject")
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "./Getting&CleaningProject/Data")



#unzip files and read in activitylabels & features data
unzip("./Getting&CleaningProject/Data")
activitylabels <- read.table("UCI HAR Dataset/activity_labels.txt")
feature <- read.table("UCI HAR Dataset/features.txt")
View(feature)
View(activitylabels)


#Read in training data and test data
train <- read.table("UCI HAR Dataset/train/X_train.txt")
trainingactivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainingsubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
test <- read.table("UCI HAR Dataset/test/X_test.txt")
testactivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testsubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")



#Label the data becareful!
## Take second column of features data and make it the 1st row or column header for the training data ("X_train.txt")
colnames(train) <- feature[,2]
## Take second column of features data and make it the 1st row or column header for the test data ("X_test.txt")
colnames(test) <- feature[,2]
###(rename column names in the remaining data sets with descriptive names)
colnames(trainingactivities) <- "trainingactivities"
colnames(trainingsubjects) <- "trainingsubjects"
colnames(testactivities) <- "testactivities"
colnames(testsubjects) <- "testsubjects"
### rename column names for the "activity_label" data with descriptive names
colnames(activitylabels) <- c("activityid", "activity")


#Merge training data & test data then add column names for subject & activity
traindata <- cbind(trainigsubjects, trainingactivities, train)
View(traindata)
testdata <- cbind(testsubjects, testactivities, test)
View(testdata)
Data <- rbind(traindata, testdata)
View(Data)

#Extract only means and std data from each measurment (or in this case columns)
grabmeaorstddatacolumns <-grep("mean|std", feature[,2])
onlymeanorstdobservation <- Data[grabmeanorstddatacolumns,]


# Make variable "activity" a factor and variable "label" a label for the activity
Data$activity <- factor(Data$activity, labels = activitylabels[,2])


#Make tidy table with means sort on subject
Tidy.Data <- melt(Data, id = c("subject","activity"))
Tidy.Data <- dcast(Tidy.Data, subject+activity ~ variable, mean)
write.table(Tidy.Data, "TidyDataSet.txt", row.name = FALSE, quote = FALSE)

 

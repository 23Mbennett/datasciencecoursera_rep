#Create directory & Download files
dir.create("Getting&CleaningProject")
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "./Getting&CleaningProject/Data")

#unzip files and read in labels & features then change to characters
unzip("./Getting&CleaningProject/Data")
labels <- read.table("UCI HAR Dataset/activity_labels.txt")
activitylabels <- as.character(labels[,2])
feature <- read.table("UCI HAR Dataset/features.txt")
featureascharacters <- as.character(feature[,2])
View(feature)
View(labels)

#grab data with means & std from features vector
meanandstd <- grep(".*mean.*|.*std.*", featureascharacters)
View(meanandstd)
meanandstddata <- feature[meanandstd,2]
meanandstddata = gsub('[-()]', '', meanandstddata)
View(meanandstddata)

#Read in training data and test data combine the required column vectors
traindata <- read.table("UCI HAR Dataset/train/X_train.txt")[meanandstd]
trainingactivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainigsubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
traindata <- cbind(trainigsubjects, trainingactivities, traindata)
View(traindata)
testdata <- read.table("UCI HAR Dataset/test/X_test.txt")[meanandstd]
testactivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testsubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
testdata <- cbind(testsubjects, testactivities, testdata)

#Merge training data & test data then add column names for subject & activity
Data <- rbind(traindata, testdata)
colnames(Data) <- c("subject","activity", meanandstddata)

# Make subject and activity factor variables
activity <- as.factor(Data$activity)
subject <- as.factor(Data$subject)

#Make tidy table with means (disregard column means for subject & activity)
t1 <- apply(Datameans, 2, mean)
t3 <- write.table(t1)



 

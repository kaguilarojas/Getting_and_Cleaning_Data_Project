#load reshape2 library used to generate tidy data set
library(reshape2)

filename <- "getdata_dataset.zip"

## Download the dataset:
if (!file.exists(filename)){
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileURL, filename)
}  

## Unzip the dataset:
if (!file.exists("UCI HAR Dataset")) { 
        unzip(filename) 
}

# Load activity labels and features
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Extracts only the measurements on the mean and standard deviation for each measurement
featuresWanted <- grep(".*mean.*|.*std.*", features[,2])
featuresWanted.names <- features[featuresWanted,2]
featuresWanted.names = gsub('-mean', 'Mean', featuresWanted.names)
featuresWanted.names = gsub('-std', 'Std', featuresWanted.names)
featuresWanted.names <- gsub('[-()]', '', featuresWanted.names)

# Load the training and test datasets
train <- read.table("UCI HAR Dataset/train/X_train.txt")[featuresWanted]
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActivities, train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[featuresWanted]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivities, test)

# Create one dataset (Merge datasets) and add the labels
mergedData <- rbind(train, test)
colnames(mergedData) <- c("subject", "activity", featuresWanted.names)

# Turn activities & subjects into factors
mergedData$activity <- factor(mergedData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
mergedData$subject <- as.factor(mergedData$subject)

# Melt data to make it tall and skinny with expected data
mergedData.melted <- melt(mergedData, id = c("subject", "activity"))
mergedData.mean <- dcast(mergedData.melted, subject + activity ~ variable, mean)

# Write reshaped data (tidy data) to a file
write.table(mergedData.mean, "tidy_data_set.txt", row.names = FALSE, quote = FALSE)
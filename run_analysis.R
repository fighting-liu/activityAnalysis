## set the working directiry, changing it when needed
setwd("/Users/liuhuawei/Desktop/DataScience/C3-getingAndCleaningData/courseProject")
## download the data
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists("./data")){
        dir.create("./data")
        download.file(fileUrl, destfile = "./data.zip")
        unzip("data.zip")
}

library(dplyr)
## get the training data and test data with subject_label and activity_label
X_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

data_train <- cbind(subject_train, y_train)
data_train <- cbind(data_train, X_train)

X_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

data_test <- cbind(subject_test, y_test)
data_test <- cbind(data_test, X_test)

## get the feature namea which are used to describe the columns
feature_names <- read.table("./data/UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
feature_names <- c("subject_label", "activity_label", feature_names$V2)

## get the activity labels which are used to name the activities
activity_label <- read.table("./data/UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)
activity_label <- activity_label$V2

## step1 and step 4: combine the train and test data
data <- rbind(data_train, data_test)
colnames(data) <- feature_names

## step2 :filter the columns with "mean" and "std
index_mean <- grep("mean", feature_names)
index_std  <- grep("std", feature_names)
index <- sort(c(index_mean, index_std))
data <- data[, c(1, 2, index)]

## step3 : name the activities
data$activity_label <- as.character(data$activity_label)
data$activity_label <- factor(data$activity_label, labels = activity_label)

## step5 :group the data and get the final pure data
grouped_data <- group_by(data, subject_label, activity_label)
pure_data <- summarise_each(grouped_data, funs(mean))
write.table(pure_data, file = "./pureData.txt", row.names = FALSE)


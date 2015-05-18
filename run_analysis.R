setwd("/Users/liuhuawei/Desktop/DataScience/C3-getingAndCleaningData/courseProject")
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists("./data")){
        dir.create("./data")
        download.file(fileUrl, destfile = "./data.zip")
        unzip("data.zip")
}

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

feature_names <- read.table("./data/UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
feature_names <- c("subject_label", "activity_label", feature_names$V2)


activity_label <- read.table("./data/UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)
activity_label <- activity_label$V2

###
data <- rbind(data_train, data_test)
colnames(data) <- feature_names
index_mean <- grep("mean", feature_names)
index_std  <- grep("std", feature_names)
index <- sort(c(index_mean, index_std))
data <- data[, c(1, 2, index)]
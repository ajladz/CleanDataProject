
# To begin with, I am checking if the data is already in a working directory. 
# If the file 'data' does not exist in a working direcotory, the block of code inside the if loop 
# should create it,download the file with  necessary data and unzip it into the 'data' file in my R working directory.

if(!file.exists('./data')){
      dir.create('./data')
      fileUrl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
      download.file(fileUrl, 'data.zip')
      unzip('data.zip', exdir = 'data')
}


# Step 1  
# Merges the training and the test sets to create one data set.

train <- read.table('./data/UCI HAR Dataset/train/X_train.txt', header = FALSE)
trainLabels <- read.table('./data/UCI HAR Dataset/train/y_train.txt', header = FALSE)
trainSubject <- read.table('./data/UCI HAR Dataset/train/subject_train.txt', header = FALSE)

test <- read.table('./data/UCI HAR Dataset/test/X_test.txt', header = FALSE)
testLabels <- read.table('./data/UCI HAR Dataset/test/y_test.txt', header = FALSE)
testSubject <- read.table('./data/UCI HAR Dataset/test/subject_test.txt', header = FALSE)

train_test_set <- rbind(train, test)


# Step 2
# Extracts only the measurements on the mean and standard deviation for each measurement. 

features <- read.table('./data/UCI HAR Dataset/features.txt')
col <- grep("mean|std", features[,2])

mean_std_set <- train_test_set[, col]
names(mean_std_set) <- features[col,2]


# Step 3
# Uses descriptive activity names to name the activities in the data set

activityLabels <- read.table('./data/UCI HAR Dataset/activity_labels.txt')
activities <- rbind(trainLabels, testLabels)
names(activities)  <- 'activities'

data_act <- cbind(activities, mean_std_set)
data_act[,1] <- as.factor(data_act[,1])
levels(data_act[,1]) <- activityLabels[,2]


# Step4
# Appropriately labels the data set with descriptive variable names. 

subjects <- rbind(trainSubject, testSubject)
names(subjects) <- 'subjects'

data <- cbind(subjects, data_act)

names(data) <- gsub('[()]', '', names(data))   # removing special characters
names(data) <- gsub('-', '_', names(data))    # replacing hyphens with underscores


# Step 5
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(reshape2)
meltedData <- melt(data, id = c('subjects', 'activities'))
tidyData <- dcast(meltedData, subjects + activities ~ ..., mean)


write.table(tidyData, "tidyData.txt", row.names = FALSE)





# To begin with, I am checking if the data is already in a working directory. 
# If the file 'data' does not exist in a working direcotory, the block of code inside the if loop 
# should download the file and unzip it into my R working directory.

if(!file.exists('./data')){
      dir.create('./data')
      fileUrl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
      download.file(fileUrl, 'data.zip')
      unzip('data.zip', exdir = 'data')
}

# Reading training set, training labels and subjects from data file
train <- read.table('./data/UCI HAR Dataset/train/X_train.txt', header = FALSE)
trainLabels <- read.table('./data/UCI HAR Dataset/train/y_train.txt', header = FALSE)
trainSubject <- read.table('./data/UCI HAR Dataset/train/subject_train.txt', header = FALSE)


# First column of a 'train' data frame will represents the subject who performed the activitiy 
# Therefore, I'll name this column/variable 'subject'
names(trainSubject) = 'subject'

# Second column of a 'train' data frame will be activity labels 
# Therefore I'll name this column/variable 'activity'
names(trainLabels) <- 'activity'

# Remaining columns will represent training set feature vectors

# Reading features from the data file into the R woking directory
features <- read.table('./data/UCI HAR Dataset/features.txt')

# Since we need to use this list of features as a variable/column names in our data frame,
# it is necessary to change these names into a form that would be more appropriate for analysis in R.
features[,2] <- gsub('[()]', '', features[,2])   # removing special characters
features[,2] <- gsub('-', '_', features[,2])    # replacing hyphens with underscores

# Now we can assign these feature labels to our variable/colum names
names(train) <- features[,2]


# Binding trainSubject, trainLabels and train set together with cbind() in one data frame called train
train <- cbind(trainSubject, trainLabels, train)




# Reading testing set, testing lables and subjects from data file
test <- read.table('./data/UCI HAR Dataset/test/X_test.txt', header = FALSE)
testLabels <- read.table('./data/UCI HAR Dataset/test/y_test.txt', header = FALSE)
testSubject <- read.table('./data/UCI HAR Dataset/test/subject_test.txt', header = FALSE)

# Now I'm repeating the same procedure with test set I already did with train set
# I'll assign appropriate names to columns/variables of tet set
names(testSubject) = 'subject'
names(testLabels) <- 'activity'
names(test) <- features[,2]

# Binding testSubject, testLabels and test set together with cbind() in one data frame called test
test <- cbind(testSubject, testLabels, test)


# At this point we have two separate data frames. 
# Data frame 'train' contains training set and data frame 'test' represents testing set.
# Next step is to bind them together with rbind()
data <- rbind(train, test)

# Extracting only the measurements on the mean and standard deviation for each measurement. 

# First step is to extract the columns of interest into a vector 'col'.
# Each item of this integer vector is an ordinal number of the column/variable containing either mean or std of measurements.
col <- grep('subject|activity|mean|std', names(data))  # meanFreq() variable included

# Second step is to subset our 'data' data frame using 'col' to label colums we want in our new data set
data <- subset(data, select = col)


# First it's necessary to change the type of activity variable from integer to factor
activity_labels <- read.table('./data/UCI HAR Dataset/activity_labels.txt')
data$activity <- as.factor(data$activity)
levels(data$activity) <- activity_labels[,2]

# For the last step, it's necessary to load the library package reshape2
library(reshape2)

# Tidying the data set
meltedData <- melt(data, id = c('subject', 'activity'))
tidyData <- dcast(meltedData, subject + activity ~ ..., mean)



# Getting and Cleaning Data Project
This is a code book that describes the variables, the data and transformations performed to clean up data.

## Description 
The purpose of this project is to demonstrate an ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 

The source data represents data collected from the accelerometers and gyroscopes from the Samsung Galaxy S smartphone.
A full description is available at the site where the data was obtained: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

In the following section I'll give a short information about the data and then proceed to explain steps taken to clean up the data, as well as information on variables used in each step.

### Attention! 
Running the run_analysis.R script will download data obtained through 'Human Activity Recognition Using Smartphones Dataset' study. That is, of course, if you do not already have that data downloaded in R working directory in which case that step will be skipped.

## Information about data 

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.  

### For each record/observation it is provided:

* A 561-feature vector with time and frequency domain variables. 
* Its activity label. 
* An identifier of the subject who carried out the experiment.

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.


## Step 1

The goal of this step is to merge the training and test sets to create one data set.

### Variables used in this step are: 
* 'train' : Training set.
* 'trainLables' : Training labels.
* 'trainSubject': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

* 'test' : Testing set.
* 'testLabels' : Testing lables.
* 'testSubject' : Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

* 'train_test_set' : Data frame obtained after merging together train and test sets.


## Step 2

The goal of this step is to extract only the measurements on the mean and standard deviation for each measurement.

### Variables used in this step are: 
* 'features' : Data frame obtained after reading in the text file 'features.txt' containing data on all features from feature vectors.
* 'col' : integer vector with ordinal numbers of columns containing only the measurements on the mean and standard seviation for each measurement.
* 'mean_std_set' : Data frame obtained after subsetting original data frame with 'col' vector.


## Step 3

The goal of this step is to name the activities in the data set using descriptive activity names.

### Variables used in this step are:
* 'activityLabels' : Data frame that links the class labels with their activity name.
* 'activities' :  Data frame containing activities for both training and testing set.
* 'data_act' : Data frame obtained after binding together 'activities' data frame and 'mean_std_set' data frame


## Step 4

The goal of this step is to appropriately label the data set with descriptive variable names.

### Variables used in this step are:
* 'subjects' : Data frame containing data on subjects from both training and testing set. Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
* 'data' : Data frame obtaines after binding together 'subjects' and 'data_act' data frame.


## Step 5

The goal of this step is to create an independent, tidy data set with the average of each variable for each activity and each subject, using the data set 'data' from step 4.

### Variables used in this step are:
* 'meltedData' : Data frame obtained after usin melt() function on 'data' data frame from reshape2 package.
* 'tidyData' : Final data frame containing averages of each variable for each activity and each subject.






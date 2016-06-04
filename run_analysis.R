library(dplyr)
library(utils)
if (!file.exists("./UCIDataset.zip"))
{
  download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "./UCIDataset.zip")
}
unzip("./UCIDataset.zip")
# Read in all the datasets
x_train <- read.delim2(file="./UCI HAR Dataset/train/X_train.txt", header=FALSE, sep = "", stringsAsFactors = FALSE)
y_train <- read.delim2(file="./UCI HAR Dataset/train/Y_train.txt", header=FALSE, sep = "", stringsAsFactors = FALSE)
x_train <- as.data.frame(sapply(x_train, as.numeric))
subject_train <- read.delim2(file="./UCI HAR Dataset/train/subject_train.txt", header=FALSE, sep = "", stringsAsFactors = FALSE)
x_test <- read.delim2(file="./UCI HAR Dataset/test/X_test.txt", header=FALSE, sep = "", stringsAsFactors = FALSE)
x_test <- as.data.frame(sapply(x_test, as.numeric))
y_test <- read.delim2(file="./UCI HAR Dataset/test/Y_test.txt", header=FALSE, sep = "", stringsAsFactors = FALSE)
subject_test <- read.delim2(file="./UCI HAR Dataset/test/subject_test.txt", header=FALSE, sep = "", stringsAsFactors = FALSE)
activity <- read.delim2(file="./UCI HAR Dataset/activity_labels.txt", header=FALSE, sep = "", stringsAsFactors = FALSE)
# set the collumn names for the activity code table for later use
colnames(activity) <- c("ActivityCode", "Activity")
# read in the features table which are the columns for the data
features <- read.delim2(file="./UCI HAR Dataset/features.txt", header=FALSE, sep = "", stringsAsFactors = FALSE)
# we only want to use the labels from the features and not the numbers
labels <- features[, 2]
# we only want to get the columns with mean() or std() in the label
useLabels = grepl("mean\\(\\)|std\\(\\)", labels)
x_train <- x_train[, useLabels]
x_test <- x_test[, useLabels]
labels <- labels[useLabels]
labels <- c(labels, "Subject", "ActivityCode")
# combine the all the training data into one table
train_data <- bind_cols(x_train, subject_train, y_train)
# combine the all the test data into one table
test_data <- bind_cols(x_test, subject_test, y_test)
# combine the all the testing and training data into one table
all_data <- rbind(train_data, test_data)
# set the column names to the lables
colnames(all_data) <- labels
# join the activity table so that activity label will show up in the final dataset
tidy_data <- inner_join(all_data, activity)
# summarize the table by subject and activitycode, and average all the variables 
summary_data <- tidy_data %>%
  group_by(Subject, ActivityCode, Activity) %>%
  summarise_each(funs(mean), -ActivityCode, -Activity, -Subject) %>%
  select(ActivityCode, Activity, Subject, everything())
# Add "Avg" to the all of the column names except the Activity, ActivityCode, and Subject columns
colNames <- colnames(summary_data)
colNames <- c(colNames[1:3], paste("Avg", colNames[4:length(colNames)]))
colnames(summary_data) <- colNames
# write the table to a file
write.table(summary_data, row.names = FALSE, file="./summary_data.txt")

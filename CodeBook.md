# CodeBook for run_analysis.R script
the script loads the utils and dplyr libraries so be sure to have those packages downloaded in your R environment
## File download
downloads the file from the URL and unzips the file in the working directory
## Read all the datasets from the files
x_train is a data frame from the X_train.txt file which contains the training data
y_train is a data frame from the Y_train.txt which contains activity codes for the training data
x_test is a data frame from the X_test.txt which contains the testing data
y_test is a data frame from the Y_test.txt which contains activity codes for the testing data
subject_test is a data frame from the subject_test.txt file which contains the subjects for all of the testing data
subject_train is a data frame from the subject_train.txt file which contains the subjects for all of the training data
activity is a data frame from the activity_labels.txt file which contains the activity names for the activity code
features is a dataframe from the features.txt file which contains the variable names for the testing and training datasets
## Setting up the data
1. Set the column names in the activity data frame to "ActivityCode", "Activity" to cross reference later
2. labels is a vector that contains only the feature names and not the feature number
3. Only the mean and standard deviation values are needed for the data so a useLabels logical vector is created to know ehich columns has std() and mean() in the labels vector
4. Extract only the columns from the x_test and x_train data - x_test, x_train
5. Add "Subject" and "ActivityCode" to the labels so they will be part of the final dataset
## Combine the data
1. Use the bind_cols function to combine all of the columns from the x_train, subject_train, and y_train datasets and assign to train_data
2. Use the bind_cols function to combine all of the columns from the x_test, subject_test, and y_test datasets and assign to test_data
3. Combine all the data into one table using the rbind function - all_data
4. Now join the Activity table with all_data table to get tidy_data using the inner_join function
5. tidy_data should have all the data needed to run the summary
## Create the summary data
Use tidy_data to average all of the variables except Subject, ActivityCode, and Activity using
summary_data <- tidy_data %>%
  group_by(Subject, ActivityCode, Activity) %>%
  summarise_each(funs(mean), -ActivityCode, -Activity, -Subject) %>% 
  select(ActivityCode, Activity, Subject, everything())
The select statement at the end is used to re-arrange the data so that Activity, and Subject are at the beginning - I could take out ActivityCode but left it in there for reference
Change the name of the variables in the summary_data to have "Avg" in the front of the variable 
Write out the summary_data to a file to summary_data.txt








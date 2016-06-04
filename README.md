# Assignment: Getting and Cleaning Data Course Project #  
List of files:  
1. run_analysis.R - R script that runs an analysis on the UCI data  
2. README.md - this file  
3. CodeBook.md - file that explains what the run_analysis script does  
4. summary_data.txt - contains the final summary data using the write.table command  
  
## Requirements ##  
R v3.3.0 or higher  
dplyr library  
util library  
tidyr library  

### Inputs ###  
The inputs will be the data files that are downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
A description of the dataset is contained here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones  
The script will download and unzip the zip file if it is not present in the current working directory  
The script assumes the files are in the same folder structure as the original zip file  
No other inputs are necessary to run the script  
  
### Outputs ###  
After running the script you should have the following files in your working directory  
1. UCIDataset.zip - the file downloaded from the URL  
2. A folder named "UCI HAR Dataset" that contains all the files and folders for the dataset  
3. summary_data.txt - the averages of the mean and std values form the datasets grouped by subject and activity  


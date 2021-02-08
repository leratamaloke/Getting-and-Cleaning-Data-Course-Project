# Getting-and-Cleaning-Data-Course-Project
EXPLANATION OF THE SCRIPT AND HOW THE CODE WORKS

#Getting and Cleaning Data - Course Project

##The course project consists of the following files.

run_analysis.R
CodeBook.md
tidy.txt
###run_analysis.R The R script performs the following data preprocessing steps.

Check if the working directory contains the folder "data" and if, necessary, creates one
Download the project dataset into the "data" directory
Load the Training and Test datasets and the tables with the appropriate labels into R
Complete assembly of Training and Test datasets with subject and activity identifiers
Combine Training and Test datasets into one dataset named allData
Use the features table to assign labels to the measurement variables in allData
Subset allData to contain only measurement variables that include either "mean" or "std" in the name
Use the activityLabels table to assign descriptive labels to the factor variable allData$activity
Rename the measurement variables to be more explicit (Ex: Accelerometer vs. Acc)
Use the merge function to reshape the dataset allData and then the dcast function to reformat and summarize the melted dataset
Write the resulting tidy dataset to a text file
###CodeBook.md The CodeBook document lists all variables and summaries calculated using the run_analysis.R script, along with units and any other relevant information.

###tidy.txt The tidy dataset contains the mean of each measurement listed in the CodeBook for each subject, for each activity performed during the experiment.

This dataset meets all of the requirements for a tidy dataset, specifically:

Each variable is in a separate column
Each different observation of that variable is in a different row
All variables in the table are the same type of observation
The tidy dataset can be read into R and viewed using the following code.

tidy <- read.table("./data/tidy.txt", header=TRUE); View(tidy)

###Additional Information Background information on the experiment and the source of the data used in this project can be found here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

#CodeBook for Run_Analysis.R
##Data Generation
The data here is sourced from the following URI:
[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

The zip archive is extracted and the main files for consideration are read into R data tables.
For this process the files considered are the "X" and "y" values and supplemental variable descriptions data.
The training and test sets are combined using rbind commands to create a single set of all subject data.

##Limit Variables and Add Variable Descriptions
The variables in the "X" datasets are limited to only mean and std measures.
This subsetting is acheived though grep and gsub functions to query and restructure names, respectively.
Care is taken with the gsub function to replace invalud character values to allow the descriptions to be used as names.
By using the following two commands the descriptions can be cleaned to allowable names:
	varNames <- gsub("-","_",f[vars,2])
	varNames <- gsub("\\(\\)","",varNames)
An example of this transformation is:
Raw:			tBodyAcc-mean()-X
Transformed:	tBodyAcc_mean_X

In this manner the information value of the descriptions is retained while the strings are cleaned for use as names.
The subject and activity attributes are also added to give observation level detail.
The Activity variable is coded with the following mapping (from activity_labels.txt):
* 1 WALKING
* 2 WALKING_UPSTAIRS
* 3 WALKING_DOWNSTAIRS
* 4 SITTING
* 5 STANDING
* 6 LAYING

This mapping is achieved through the following commands:
* a <- read.table("../activity_labels.txt")
* tidy$activity <- a[yFull[,1],2]

#Aggregate numeric variables
The remaining numeric variables are averaged over the subject (30) and activity (6) categories.
The names transformed from features.txt are retained, as well as the subject and activity categorical variable names.
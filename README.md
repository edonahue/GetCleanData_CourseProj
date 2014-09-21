#Creating a Tidy Dataset of Accelerometer Data

This process consists of a single script in the R language, Run_Analysis.R.
Run_Analysis.R reads in a zip archive file sourced from the following URI:
[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

##Five main steps are taken to transform the raw data and produce a tidy set:
* Read Data and Files
* Combine Train and Test Data
* Limit variables to only mean and std measures
* Add subject number and activity variables and descriptive variable names
* Aggregate data for averages of each numeric variable by activity and subject

###Read Data and Files
* The zip file is downloaded using download.file() with default settings
* The source file is unzipped 
* The train and test data ("X_", "y_" and subjects) is read using read.table with default settings

###Combine Train and Test Data
* Train and Test directories are navigated using setwd()
* Training and Test sets are combined using rbind, e.g.  rbind(xTrain, xTest)

###Limit Variables
* The "features.txt" file is read using read.table, including descriptions and positions of variables
* The grep function is used to return variable positions with the description patterns "mean()" and "std"
* This list of positions (saved as object "vars") is used to subset the variables, e.g. xFull[,vars]

###Add Subject and Activity, Variable Names
* "subject" and "activity" attributes are added using the combined objects from the train and test sets
* Variable names are pulled from the "features.txt" file used to subset the variables earlier,
* Variable descriptions are cleaned from "features.txt" using the gsub function to replace invalid characters, e.g. gsub("-","_",f[vars,2])
* The cleaned version of the variables names list is assigned using names()

###Aggregate Tidy Data
* The aggregate function is used to calculate averages (using FUN="mean") for all numeric variables, grouped by Activity and Subject
* The grouping variable names (activity, subject) are retained with by=list(activity=tidy$activity, subject=tidy$subject)
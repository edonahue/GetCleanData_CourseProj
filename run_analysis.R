# Download zip archive and unzip
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "UCI.zip", method="curl")
unzip("UCI.zip")
# Read in x,y, and subject test data
setwd("UCI HAR Dataset/test")
xTest <- read.table("X_test.txt")
subTest <- read.table("subject_test.txt")
yTest <- read.table("y_test.txt")
# Read in x,y, and subject training data
setwd("../train")
xTrain <- read.table("X_train.txt")
subTrain <- read.table("subject_train.txt")
yTrain <- read.table("y_train.txt")
# Combine the training and test sets using rbind
xFull <- rbind(xTrain, xTest)
yFull <- rbind(yTrain, yTest)
subFull <- rbind(subTrain, subTest)

# Limit variables returned to only mean or standard deviation measures
f <- read.table("../features.txt")

# For mean variables I've chosen only those which seem to mean 
# mean measures of the related variable.  These all conveniently 
# have lower case "mean()" strings.  Note that this excludes
# variables of the type "meanFreq()".
meanVars <- grep("mean\\(\\)",f[,2],)
stdVars <- grep("std",f[,2])

# mean and std variables are combined, with mean vars first, then std
vars <- c(meanVars,stdVars)

#Limit the variables of xFull to those selected with grep
tidy <- xFull[,vars]

# Add subject identifier to tidy dataset 
tidy$subject <- subFull[,1]
#Read in activity descriptions and assign based on y values
a <- read.table("../activity_labels.txt")
tidy$activity <- a[yFull[,1],2]

# Create and store variable names
# Labels are created by substituting the hyphens with underscores and 
# deleting the "()".  This way the original descriptions can be copied
varNames <- gsub("-","_",f[vars,2])
varNames <- gsub("\\(\\)","",varNames)
varNames <- c(varNames,"subject","activity")

# Add names to the tidy set
names(tidy) <- varNames

# Create an aggregated set with averages for all numeric values group
# by activity and subject
tidyAvg <- aggregate(tidy[,1:66],by=list(activity=tidy$activity, subject=tidy$subject), FUN="mean")
setwd("../../")
write.table(tidyAvg, "tidyAvg.txt", row.name=FALSE)

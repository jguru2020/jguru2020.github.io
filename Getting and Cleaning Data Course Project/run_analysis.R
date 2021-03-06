#Preparation by loading the relevant packages
library(dplyr)

#Access the data files by downloading the archive file
archiveDataFile = "Coursera_DS3_Final.zip"
if (!file.exists(archiveDataFile))
{
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, archiveDataFile, method="curl")
}  

#Unzip to a folder
if (!file.exists("UCI HAR Dataset")) 
{ 
  unzip(archiveDataFile) 
}

# Creating data frames by reading appropriate data files
features = read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities = read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test = read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test = read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test = read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train = read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train = read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train = read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

#Merging training and test data sets into one
dataX = rbind(x_train, x_test)
dataY = rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
Merged_Data = cbind(subject, dataY, dataX)

#Extracting only the measurements on the mean and standard deviation for each measurement
tidyData <- Merged_Data %>% select(subject, code, contains("mean"), contains("std"))


# Using descriptive activity names to name the activities in the data set

tidyData$code = activities[tidyData$code, 2]

# Re-name variables to have  meaningful descriptive names
names(tidyData)[2] = "activity"

names(tidyData) = gsub("^t", "Time", names(tidyData))
names(tidyData) = gsub("^f", "Frequency", names(tidyData))
names(tidyData) = gsub("-mean()", "Mean", names(tidyData), ignore.case = TRUE)
names(tidyData) = gsub("-std()", "StandardDeviation", names(tidyData), ignore.case = TRUE)
names(tidyData) = gsub("-freq()", "Frequency", names(tidyData), ignore.case = TRUE)
names(tidyData) = gsub("Acc", "Accelerometer", names(tidyData))
names(tidyData) = gsub("Gyro", "Gyroscope", names(tidyData))
names(tidyData) = gsub("BodyBody", "Body", names(tidyData))
names(tidyData) = gsub("Mag", "Magnitude", names(tidyData))
names(tidyData) = gsub("tBody", "TimeBody", names(tidyData))
names(tidyData) = gsub("angle", "Angle", names(tidyData))
names(tidyData) = gsub("gravity", "Gravity", names(tidyData))

# Creating another tidy data set with the average of each variable for each activity and each subject
anotherTidyData = tidyData %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(anotherTidyData, "AnotherTidyData.txt", row.name=FALSE)

str(anotherTidyData)

anotherTidyData #printing data onto console

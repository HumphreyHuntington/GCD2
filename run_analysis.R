
getwd()
setwd("~/Coursera/Getting and Cleaning Data/")

library(plyr)
library(dplyr)
library(tidyr)
library(ggplot2)


### Phase 1: Merges the training and the test sets to create one data set.

Data_TRA <- read.table("./UCI HAR Dataset/train/X_train.txt")
Data_TES <- read.table("./UCI HAR Dataset/test/X_test.txt")
Data <- rbind(Data_TRA, Data_TES)

Label_TRA <- read.table("./UCI HAR Dataset/train/y_train.txt")
Label_TES <- read.table("./UCI HAR Dataset/test/y_test.txt")
Label <- rbind(Label_TRA, Label_TES)

Subject_TRA <- read.table("./UCI HAR Dataset/train/subject_train.txt")
Subject_TES <- read.table("./UCI HAR Dataset/test/subject_test.txt")
Subject <- rbind(Subject_TRA, Subject_TES)



### Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.
features <- read.table("./UCI HAR Dataset/features.txt")
features_names <- features [,2]
names(Data) <- features_names

Measures_mean_std <- grep("mean\\(\\)|std\\(\\)", features[, 2])
Data2 <- Data[, Measures_mean_std]



### Phase 3: Uses descriptive activity names to name the activities in the data set.
Activity <- read.table("./UCI HAR Dataset/activity_labels.txt")
Label[, 1] <- Activity[Label[, 1], 2]
names(Label) <- "Activity"



### Phase 4: Appropriately labels the data set with descriptive activity names.
names(Subject) <- "Subject"
Data_final <- cbind(Subject, Label, Data2)



### Phase 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Subject_Nbr <- length(table(Subject)) 
Activity_Nbr <- dim(Activity)[1] 
Column_Nbr <- dim(Data_final)[2]

Data_tidy <- matrix(NA, nrow=Subject_Nbr*Activity_Nbr, ncol=Column_Nbr)
Data_tidy <- as.data.frame(Data_tidy)
colnames(Data_tidy) <- colnames(Data_final)
row <- 1
for(i in 1:Subject_Nbr) {
  for(j in 1:Activity_Nbr) {
    Data_tidy[row, 1] <- sort(unique(Subject)[, 1])[i]
    Data_tidy[row, 2] <- Activity[j, 2]
    run1 <- i == Data_final$Subject
    run2 <- Activity[j, 2] == Data_final$Activity
    Data_tidy[row, 3:Column_Nbr] <- colMeans(Data_final[run1&run2, 3:Column_Nbr])
    row <- row + 1
  }
}
write.table(Data_tidy, "data_tidy.txt") 

GCD2
====

The objective of this Readme file is to explain how the run_Analysis.R works. 

* First, you need to download and unzip the data from Coursera assignment webpage and keep the names and structures of the folders. However, do make sure that these folders are in the correct working directory. 
* Second, open run_analysis.R in RStudio and let in run.
* Finally, you will find the data_tidy.txt (180 rows by 68 colums) in the current working directory. 

The objective of this Codebook-part is to explain how the various steps in the cleaning of the data has been done. 
* First, I downloaded and unzipped the data from Coursera assignment webpage (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and kept the names and structures of the folders. 
* Second, run_analysis.R performs the following phases in data cleaning. 
** In phase one it reads the X_train.txt, y_train.txt and subject_train.txt AND X_test.txt, y_test.txt and subject_test.txt. 
These files are then used to create the files 'Data' 'Label' & 'Subject' by concatenating them.  
** In Phase two it reads in features.txt, of which only those measurements concerning the mean or the standard deviation are kept, resulting in 66 variables.   
** In Phase three I read in the activity_labels.txt. 
** In Phase 4 I join together the files DATA, Subject and Label. 
** Phase 5 creates a second, independent tidy data set with the average of each variable for each activity and each subject. In the end we remain with a 180x68 data frame. 

library(dplyr)

# Reading datasets and giving coloumn names
  
  features <- read.table("UCI HAR Dataset/features.txt",col.names = c("sl.no","function"))
  activity <- read.table("UCI HAR Dataset/activity_labels.txt",col.names = c("code","activity"))
  subjecttest <- read.table("UCI HAR Dataset/test/subject_test.txt",col.names = "subject")
  x_test <- read.table("UCI HAR Dataset/test/X_test.txt",col.names = features$function.)
  y_test <- read.table("UCI HAR Dataset/test/y_test.txt",col.names = "code")
  subjecttrain <- read.table("UCI HAR Dataset/train/subject_train.txt",col.names = "subject")
  x_train <- read.table("UCI HAR Dataset/train/X_train.txt",col.names = features$function.)  
  y_train <- read.table("UCI HAR Dataset/train/y_train.txt",col.names = "code")

# Row binding datasets
  
  Xtrain_test <- rbind(x_train,x_test) 
  Ytrain_test <- rbind(y_train,y_test)
  subject <- rbind(subjecttrain,subjecttest)

# 1 Merging the training and the test sets to create one data set.
  
  Combined_data <- cbind(subject,Ytrain_test,Xtrain_test)
  
# 2 Extracting only the measurements on the mean and standard deviation for each measurement.
  
  Tidy_data <- select(Combined_data,subject,code,matches("mean"),matches("std"))

# 3 Useing descriptive activity names to name the activities in the data set
  
  Tidy_data$code <- activity[Tidy_data$code, 2]
   
# 4 Appropriately labeling the data set with descriptive variable names.

  names(Tidy_data)
  names(Tidy_data) <- gsub("subject","Subject",names(Tidy_data))
  names(Tidy_data) <- gsub("code","Activities",names(Tidy_data))
  names(Tidy_data) <- gsub("^t", "Time", names(Tidy_data))
  names(Tidy_data) <- gsub("^f", "Frequency", names(Tidy_data))
  names(Tidy_data) <- gsub("Acc","Accelerometer",names(Tidy_data))
  names(Tidy_data) <- gsub("Gyro","Gyroscope",names(Tidy_data))
  names(Tidy_data) <- gsub("angle","Angle",names(Tidy_data))
  names(Tidy_data) <- gsub("gravity","Gravity",names(Tidy_data))
  names(Tidy_data) <- gsub("Mag","Magnitude",names(Tidy_data))
  names(Tidy_data) <- gsub("BodyBody","Body",names(Tidy_data))
  names(Tidy_data) <- gsub(".mean",".Mean",names(Tidy_data))
  names(Tidy_data) <- gsub(".std",".STD",names(Tidy_data))
  names(Tidy_data) <- gsub("tBody","TimeBody",names(Tidy_data))
  names(Tidy_data) <- gsub("...X",".X",names(Tidy_data))
  names(Tidy_data) <- gsub("...Y",".Y",names(Tidy_data))
  names(Tidy_data) <- gsub("...Z",".Z",names(Tidy_data))
  
# 5 From the data set in step 4, creating a second, independent tidy data set with the average of
#   each variable for each activity and each subject.

   Final_data <- Tidy_data %>% group_by(Subject,Activities) %>% summarise_all(funs(mean))  

# 6  Creating txt file with write.table() using row.name=FALSE     
    
    write.table(Final_data,"Final_data.txt",row.names = FALSE)
    
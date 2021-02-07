# Getting-and-Cleaning-Data-Course-Project
EXPLANATION OF THE SCRIPT AND HOW THE CODE WORKS

I applied all same read format to the files. I used sep="" cause given file format seperated like that, also header=FALSE just because I did not want to lose the first row of the data. If its header=TRUE, first row would be column names which is not what i was looking for.

Reads these two file from UCI HAR Dataset and takes sensitive data. For activitiy labels first column includes rownumber which is unneccesary.

##Reading Features and ActivityLabels vector
   
features <- read.csv("features.txt", sep = "", header = FALSE)[2]; 
activities <- read.csv("activity_labels.txt", sep = "", header = FALSE)
   
Again reads from same location and combine test and train set with rbind function.

##Reading Sets
   
testSet <- read.csv("test/X_test.txt", sep = "", header = FALSE)
trainSet <- read.csv("train/X_train.txt", sep = "", header = FALSE)
mergedSet <- rbind(testSet,trainSet)    
   
Same exact things with previous step

##Reading Movement
   
testMoves <- read.csv("test/Y_test.txt", sep = "", header = FALSE)
trainMoves <- read.csv("train/Y_train.txt", sep = "", header = FALSE)
mergedMoves <- rbind(testMoves, trainMoves)
      
##Reading PersonID
   
testPerson <- read.csv("test/subject_test.txt", sep = "", header = FALSE)
trainPerson <- read.csv("train/subject_train.txt", sep = "", header = FALSE)
mergedPerson <- rbind(testPerson, trainPerson)
   
Assigns real column attributes(decriptive column names) that is kept in features vector to mergedSet we have formed in previous steps. After that, select all columns that key values passing through this attributes

##Extracting columns which includes measurements
   
names(mergedSet) <- features[ ,1]
mergedSet <- mergedSet[ grepl("std|mean", names(mergedSet), ignore.case = TRUE) ] 
   
Descriptive values for activity columns.

##Descriptive ActivityName analysis
   
mergedMoves <- merge(mergedMoves, activities, by.x = "V1", by.y = "V1")[2]
mergedSet <- cbind(mergedPerson, mergedMoves, mergedSet)
names(mergedSet)[1:2] <- c("PersonID", "Activities")
   
Tidying set according to personID and activities

##Tidying mergedSet
   
group_by(mergedSet, PersonID, Activities) %>%
summarise_each(funs(mean))

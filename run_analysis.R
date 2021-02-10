if(!file.exists("data")) {dir.create("data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/phoneData.zip")
unzip("./data/phoneData.zip",exdir="data",unzip = "internal")

subjectTest <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
xtest <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("./data/UCI HAR Dataset/test/y_test.txt")                    

subjectTrain <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
xtrain <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("./data/UCI HAR Dataset/train/y_train.txt")

activityLabels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
features <- read.table("./data/UCI HAR Dataset/features.txt")

Train <- cbind(subjectTrain,ytrain,xtrain)
Test <- cbind(subjectTest,ytest,xtest)

allData <- rbind(Train,Test)

colnames(allData) <- c("subject", "activity", as.character(features[,2]))

temp <- grepl("subject | activity |.*mean.* |.*std.*", names(allData))
allData <- allData[,temp]

allData$activity <- factor(allData$activity, levels = activityLabels[,1], labels = as.character(activityLabels[,2]))

allData$subject <- as.factor(allData$subject)

names(allData) <- sub("Acc","Accelerometer",names(allData))
names(allData) <- sub("Gyro","Gyroscope",names(allData))
names(allData) <- sub("Mag","Magnitude",names(allData))
names(allData) <- sub("Freq","Frequency",names(allData))
names(allData) <- sub("^t","TimeDomain",names(allData))
names(allData) <- sub("^f","FrequencyDomain",names(allData))
names(allData) <- gsub("-","",names(allData))
names(allData) <- sub("mean","Mean",names(allData))
names(allData) <- sub("std","StandardDeviation",names(allData))
names(allData) <- sub("[-(]","",names(allData))
names(allData) <- sub("[-)]","",names(allData))

tidyMelted <- melt(allData, id = c("subject", "activity"))

tidyMean <- dcast(tidyMelted, subject + activity ~ variable, mean)

write.table(tidyMean, "./data/tidydata.txt", row.names = FALSE, quote = FALSE)
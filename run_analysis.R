## This is the course project of Getting and Cleaning Data
## Authorized by K. D. Liao
## Version 1
library(dplyr)
setwd("~/Coursera/Getting and Cleaning Data/project/UCI HAR Dataset/")
## Read all the data and assign activity labels
features <- read.table("features.txt")
act_lb <- c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")

train_set <- read.table("train/X_train.txt")
train_lb <- read.table("train/y_train.txt")

test_set <- read.table("test/X_test.txt")
test_lb <- read.table("test/y_test.txt")

test_sub <- read.table("test/subject_test.txt")
train_sub <- read.table("train/subject_train.txt")

readIn = FALSE;
if (readIn){
        train_body_acc_x <- read.table("train/Inertial Signals/body_acc_x_train.txt")
        train_body_acc_y <- read.table("train/Inertial Signals/body_acc_y_train.txt")
        train_body_acc_z <- read.table("train/Inertial Signals/body_acc_z_train.txt")
        train_body_gyro_x <- read.table("train/Inertial Signals/body_gyro_x_train.txt")
        train_body_gyro_y <- read.table("train/Inertial Signals/body_gyro_y_train.txt")
        train_body_gyro_z <- read.table("train/Inertial Signals/body_gyro_z_train.txt")
        train_total_x <- read.table("train/Inertial Signals//total_acc_x_train.txt")
        train_total_y <- read.table("train/Inertial Signals//total_acc_y_train.txt")
        train_total_z <- read.table("train/Inertial Signals//total_acc_z_train.txt")
        
        test_body_acc_x <- read.table("test/Inertial Signals/body_acc_x_test.txt")
        test_body_acc_y <- read.table("test/Inertial Signals/body_acc_y_train.txt")
        test_body_acc_z <- read.table("test/Inertial Signals/body_acc_z_train.txt")
        test_body_gyro_x <- read.table("test/Inertial Signals/body_gyro_x_train.txt")
        test_body_gyro_y <- read.table("test/Inertial Signals/body_gyro_y_train.txt")
        test_body_gyro_z <- read.table("test/Inertial Signals/body_gyro_z_train.txt")
        test_total_x <- read.table("test/Inertial Signals//total_acc_x_train.txt")
        test_total_y <- read.table("test/Inertial Signals//total_acc_y_train.txt")
        test_total_z <- read.table("test/Inertial Signals//total_acc_z_train.txt")
}

# Assign colnames on set with feature[,2], XXX_lb with "act", and XXX_sub with  subject
colnames(train_set) <- features[,2]
colnames(test_set) <- features[,2]
colnames(train_lb) <- "act"
colnames(test_lb) <- "act"
colnames(train_sub) <- "subject"
colnames(test_sub) <- "subject"

train_all <- cbind(train_sub,train_lb, train_set)
test_all <- cbind(test_sub, test_lb, test_set)

if (!any(is.na((match(unique(test_all$subject),unique(train_all$subject))))==F)){
        allData <- rbind(test_all, train_all)
}

rm(test_lb, test_sub, test_set, train_lb, train_sub, train_set)

# Arrange the data by subject
colnames(allData) <- make.names(colnames(allData),unique=TRUE)
allData <- arrange(allData, subject)

col_mn <- grep('mean()', colnames(allData))
col_std <- grep('std()', colnames(allData))
col_stdmn <- sort(c(col_mn, col_std))

mnstdData <- allData[, c(1,2,col_stdmn)]        

# Name the activity
nameact <- function(x) act_lb[x]
mnstdData <- mutate(mnstdData, act = nameact(act))

# Group by subject & activity
# grData <- group_by(mnstdData, subject, act)
ReSulT <- mnstdData %>% group_by(subject,act) %>% summarise_each(funs(mean))

write.table(ReSulT, file="~/Coursera/Getting and Cleaning Data/project/UCI HAR Dataset/dataset.txt",row.names=F)




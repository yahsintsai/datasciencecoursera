#setwd("/Users/yahsintsai/Downloads/UCI HAR Dataset")
train.label <- read.table("features.txt", sep = " ")
test.label <- read.table("activity_labels.txt", sep=" ")
#setwd("/Users/yahsintsai/Downloads/UCI HAR Dataset/train")
X.train <- read.table("X_train.txt")
y.train <- read.table("y_train.txt", sep=" ")
#setwd("/Users/yahsintsai/Downloads/UCI HAR Dataset/test")
X.test <- read.table("X_test.txt")
y.test <- read.table("y_test.txt", sep = " ")

## 1. Merges the training and the test sets to create one data set.
train <- cbind(X.train, y.train)
test <- cbind(X.test, y.test)
dt <- rbind(train, test)
View(dt)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
col.no.means <-  grep("mean[^Freq]()", train.label[, 2]) ## mean
dt.means <- dt[, col.no.means]
View(dt.means)
col.no.std <- grep("std()", train.label[, 2]) ## std
dt.std <- dt[, col.no.std]
View(dt.std)

## 3. Uses descriptive activity names to name the activities in the data set
for (i in 1:nrow(dt)){
  dt[i, 562] <- test.label[dt[i, 562], 2] 
}
View(dt[, 562])

## 4. Appropriately labels the data set with descriptive variable names.
dt.descriptive <- dt
colnames(dt.descriptive) <- c(train.label[,2], "activities")
View(dt.descriptive)

## 5. From the data set in step 4, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject.
ave.by.activities <- aggregate(dt.descriptive[, 1:561], list(dt.descriptive$activities), mean)
View(ave.by.activities)

write.table(ave.by.activities, file="tidy_dataset.txt")

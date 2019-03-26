#read train data
x_train <- read.table("./train/X_train.txt")

y_train <- read.table("./train/Y_train.txt")

sub_train <- read.table("./train/subject_train.txt")

#read test data
x_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/Y_test.txt")
sub_test <- read.table("./test/subject_test.txt")

#read features description
features <- read.table("./features.txt")

#read activity labels
activity_labels <- read.table("./activity_labels.txt")

#merge of training and test sets
x_total <- rbind(x_train,x_test)
y_total <- rbind(y_train,y_test)
sub_total <- rbind(sub_train,sub_test)

# Extracts only the measurements on the mean and standard deviation for each measurement
features_selected <- features[grep("mean|std",features[,2]),]
x_total <- x_total[,features_selected[,1]]

# Uses descriptive activity names to name the activities in the data set
colnames(y_total) <- "label"
y_total$activity <- factor(y_total$label, labels = as.character(activity_labels[,2]))
activity <- y_total$activity

# Appropriately labels the data set with descriptive variable names
colnames(x_total) <- features[features_selected[,1],2]

# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
colnames(sub_total) <- "subject"

#subject=sub_total$subject
combine <- cbind(x_total, activity, sub_total)
temp <- group_by(combine,activity, subject)
final <- summarize_all(temp,funs(mean))


# write final tidy data
write.table(final, file = "./tidy_data.txt", row.names = FALSE, col.names = TRUE)




























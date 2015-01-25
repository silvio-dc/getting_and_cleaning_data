# read the raw-input-files into R
x_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/y_test.txt")
subjects_test <- read.table("./test/subject_test.txt")

x_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")
subjects_train <- read.table("./train/subject_train.txt")

# do step 1: 
# put all the data together (test and train measurements, activities and subjects)
full_data <- rbind(cbind(x_test,y_test,subjects_test),
                   cbind(x_train,y_train,subjects_train))

# add the variable names mainly by taking the names of the features.txt and 
# correct some things (no "()" and "BodyBody" to "Body")
fetnames <- read.table("features.txt")
fetnames[,2] <- as.character(fetnames[,2])
colnames(full_data) <- c(fetnames[,2],"activity","subject")

filt_data <- full_data[,c(which(grepl("mean\\(\\)",fetnames[,2]) | grepl("-std\\(\\)",fetnames[,2])),dim(fetnames)[1]+1,dim(fetnames)[1]+2)]
colnames(filt_data) <- gsub("BodyBody","Body",colnames(filt_data))
colnames(filt_data) <- gsub("\\(\\)","",colnames(filt_data))

# replace the labels of activity with more explaining text
filt_data$activity <- as.character(filt_data$activity)
filt_data$activity[which(filt_data$activity=="1")] <- "Walking"
filt_data$activity[which(filt_data$activity=="2")] <- "Walking_upstairs"
filt_data$activity[which(filt_data$activity=="3")] <- "Walking_downstairs"
filt_data$activity[which(filt_data$activity=="4")] <- "Sitting"
filt_data$activity[which(filt_data$activity=="5")] <- "Standing"
filt_data$activity[which(filt_data$activity=="6")] <- "Laying"

# compute the means for each variable grouped by the activity and the subject
n <- dim(filt_data)[2]
tidySol <- aggregate(filt_data[,-c(n-1,n)],by=list(filt_data$activity,filt_data$subject),FUN=mean,na.rm=TRUE)
colnames(tidySol)[1:2]<-c("activity","subject")

tidySol
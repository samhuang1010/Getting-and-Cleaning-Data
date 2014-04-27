#supress the scientitifc notation  
options(scipen=100)

#Read in variable names & assign them as the column names
features=read.table('UCI HAR Dataset/features.txt', sep=" ")

#Read in data
traindata=read.table('UCI HAR Dataset/train/X_train.txt', header=FALSE, col.names=features[,2])

testdata=read.table('UCI HAR Dataset/test/X_test.txt', header=FALSE, col.names=features[,2])

#check if there is any missing value
all(colSums(is.na(traindata))==0)
all(colSums(is.na(testdata))==0)

#Read in subject information
trainsub=read.table('UCI HAR Dataset/train/subject_train.txt', header=FALSE)
testsub=read.table('UCI HAR Dataset/test/subject_test.txt', header=FALSE)
names(trainsub)=c("subject")
names(testsub)=c("subject")

#Combine subject information with data 
test<-cbind(testsub, testdata)
train<-cbind(trainsub, traindata)

#Combine training and testing data sets
total<-rbind(test, train)

#Extract data of means and std only
meanstdfeatures <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
total <- total[,meanstdfeatures]
names(total) <- features[meanstdfeatures, 2]
names(total) <- gsub("\\(|\\)", "", names(total))

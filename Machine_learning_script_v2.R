# Machine learning project
# Coursera

setwd("C:/lalala")

path_training <- "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv"
path_test <- "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv"

download.file(path_training, "training.csv")
train_set <- read.csv("training.csv", stringsAsFactors = FALSE)

download.file(path_test, "test.csv")
test_set <- read.csv("test.csv", stringsAsFactors = FALSE)

missing_data <- data.frame(names = colnames(train_set), NAS = 0)

for (i in 1:length(missing_data$names)){
  y <- sum(is.na(train_set[,i]))
  z <- ifelse(is.na(sum(train_set[,i]=='')),0,sum(train_set[,i]=='') )
  missing_data$NAS[i] <- z + y
}

delete <- which(missing_data$NAS>10000) #REmove the variables that lack data
train_set2 <- train_set[,-delete]
train_set2 <- train_set2[,-(1:6)]
test_set2 <- test_set[,-delete]
test_set2 <- test_set2[,-(1:6)]       

Correlated <- caret::findCorrelation(cor(train_set2[,-54]), cutoff=0.9) #Correlated variables.

if (length(Correlated)>0) {
  tc <- trainControl(method = "cv", number = 7, verboseIter=FALSE , preProcOptions="pca", allowParallel=TRUE)
} else {
  tc <- trainControl(method = "cv", number = 7, verboseIter=FALSE , allowParallel=TRUE)
}

rf <- train(classe ~ ., data = train_set2, method = "rf", trControl= tc) # Random forest
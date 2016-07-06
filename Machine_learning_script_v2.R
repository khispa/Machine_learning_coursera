# Machine learning project
# Coursera

setwd("C:/lalala")

path_training <- "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv"
path_test <- "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv"

download.file(path_training, "training.csv")
train_set <- read.csv("training.csv", stringsAsFactors = FALSE)

download.file(path_test, "test.csv")
test_set <- read.csv("test.csv", stringsAsFactors = FALSE)
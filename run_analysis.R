##run_analysis.r
##Getting and Cleaning Data Assignment 
##Robert Ben Parkinson
##23-Dec-2015


##various possible NA strings
na_strings <- c("NA", "<NA>", "Nan", " ")


##import the six primary data frames in the TRAIN and TEST files
t1 <- read.table("coursera/UCI/train/subject_train.txt", na.strings = na_strings)
t2 <- read.table("coursera/UCI/train/X_train.txt", na.strings = na_strings)
t3 <- read.table("coursera/UCI/train/y_train.txt", na.strings = na_strings)
t4 <- read.table("coursera/UCI/test/subject_test.txt", na.strings = na_strings)
t5 <- read.table("coursera/UCI/test/X_test.txt", na.strings = na_strings)
t6 <- read.table("coursera/UCI/test/y_test.txt", na.strings = na_strings)


##imports in the column names from features.txt file
features <- read.table("coursera/UCI/features.txt")


##opens the dplyr library. This assumes that you have already installed package
library(dplyr)


##ensures that the features table is a data frame
tbl_df(features)


##starting with the TRAIN file
##the subject_train file saved as t1 is saved as bigset_train
bigset_train <- t1

##the first column is readnamed "users"
colnames(bigset_train)[1] <- "users"

##a column named "testtrain" is added along with the variable "train"
##in case we need to used slipt the set in the future
bigset_train <- mutate(bigset_train, testtrain = "TRAIN")

##readable names are added to X_train files
colnames(t2) <- features$V2

##the standard deviation and mean columns as seperated out and placed into a vector
stand_mean <- c(1:6, 41:46, 81:86, 121:126, 161:166, 201:202, 214:215, 
                     227:228, 240:241, 253:254, 266:271, 345:350, 424:429,
                     503:504, 516:517, 529:530, 542,543)

##the standard deviation and mean columns as seperated out and placed into a vector 
t2 <- t2[stand_mean]

##the number references are replaced in the y_train file with readable names
t3[t3==1] <- "WALKING"
t3[t3==2] <- "UPSTAIRS"           ##walking upstairs
t3[t3==3] <- "DOWNSTAIRS"         ##walking downstairs
t3[t3==4] <- "SITTING"
t3[t3==5] <- "STANDING"
t3[t3==6] <- "LAYING"

##the y-train column is read named "activites"
colnames(t3)[1] <- "activities"

##the bigset_train, t2, and t3 data sets are combined into bigset_train 
bigset_train <- cbind(bigset_train, t2, t3)


##starting with the Test file
##the subject_train file saved as t2 is saved as bigset_test
bigset_test <- t4

##the first column is readnamed "users"
colnames(bigset_test)[1] <- "users"


##a column named "testtrain" is added along with the variable "test"
##in case we need to used slipt the set in the future
bigset_test <- mutate(bigset_test, testtrain = "TEST")


##readable names are added to X_test files
colnames(t5) <- features$V2


##the number references are replaced in the y_train file with readable names
t6[t6==1] <- "WALKING"
t6[t6==2] <- "UPSTAIRS"       ##walking upstairs
t6[t6==3] <- "DOWNSTAIRS"     ##walking downstairs
t6[t6==4] <- "SITTING"
t6[t6==5] <- "STANDING"
t6[t6==6] <- "LAYING"


##the y_test column is read named "activites"
colnames(t6)[1] <- "activities"


##the standard deviation and mean columns as seperated out and placed into a vector 
t5 <- t5[stand_mean]


##the bigset_test, t5, and t5 data sets are combined into bigset_test
bigset_test <- cbind(bigset_test, t5, t6)


##using rbin() bigset_train and bigset_test are merged together to form bigset
bigset <- rbind(bigset_train, bigset_test)

##bigset is reordered to move the activites column to the front 
bigset <- select(bigset, 1, 69, 2:68)


##any "na" are removed
bigset <- na.omit(bigset)

##i've simply ran out of names at this point
##the vector t7 contains the six activies found in the dataset
t7 <- c("WALKING", "UPSTAIRS", "DOWNSTAIRS", "SITTING", "STANDING", "LAYING")


clean_names <- c("users", "activities", "testtrain", "tB-A-mean-X", "tB-A-mean-Y", "tB-A-mean-Z",
                 "tB-A-std-X", "tB-A-std-Y", "tB-A-std-Z", "tG-A-mean-X", "tG-A-mean-Y", "tG-A-mean-Z", 
                 "tG-A-std-X", "tG-A-std-Y", "tG-A-std-Z", "tB-AJ-mean-X", "tB-AJ-mean-Y", "tB-AJ-mean-Z",
                 "tB-AJ-std-X", "tB-AJ-std-Y", "tB-AJ-std-Z", "tB-G-mean-X", "tB-G-mean-Y", "tB-G-mean-Z",
                 "tB-G-std-X", "tB-G-std-Y", "tB-G-std-Z", "tB-GJ-mean-X", "tB-GJ-mean-Y", "tB-GJ-mean-Z",
                 "tB-GJ-std-X", "tB-GJ-std-Y", "tB-GJ-std-Z", "tB-AM-mean", "tB-AM-std", "tG-AM-mean",
                 "tG-AM-std", "tB-AJM-mean", "tB-AJM-std", "tB-GM-mean", "tB-GM-std", "tB-GJM-mean",
                 "tB-GJM-std", "fB-A-mean-X", "fB-A-mean-Y", "fB-A-mean-Z", "fB-A-std-X", "fB-A-std-Y",
                 "fB-A-std-Z", "fB-AJ-mean-X", "fB-AJ-mean-Y", "fB-AJ-mean-Z", "fB-AJ-std-X", "fB-AJ-std-Y",
                 "fB-AJ-std-Z", "fB-G-mean-X", "fB-G-mean-Y", "fB-G-mean-Z", "fB-G-std-X", "fB-G-std-Y",
                 "fB-G-std-Z", "fB-AM-mean", "fB-AM-std", "fBB_AJM-mean", "fBB_AJM-std", "fBB_GM-mean",
                 "fBB_GM-std", "fBB_GJM-mean", "fBB_GJM-std")


##switch used for the if statement below
zzz <- FALSE


    ##the double for loop below will sort get the mean for each user for each activity
    ##i represents ther users in the study
    for(i in 1:30){
      
        ##x represents the six activites found in the study 
        for(z in t7){
          
            ##the initial run will form the tidy dataset      
            if(zzz == FALSE){
                
                ##filters by users and activities
                xtidy <- filter(bigset, users == i & activities == z)
                
                ##slices off the firts three columsn of the data set
                ##these are the information columns and are saved as xtidyA
                xtidyA <- select(xtidy, 1:3)
                
                ##the first row of the dataset is sliced and saved as xtidtA
                xtidyA <- xtidyA[1,]
                
                ##slices off the remaining 66 numereic columns and saves as xtidyB
                xtidyB <- select(xtidy, 4:69)
                
                ##using apply the mean is taken across all 66 columns
                xtidyB <- t(apply(xtidyB, 2, mean))
                
                ##for the sake of clarity only the first 4 significant digits are kept
                xtidyB <- round(xtidyB, 4)
                
                ##xtidayA and xtidyB are merged using cbind() to form tidy dataset
                tidy <- cbind(xtidyA, xtidyB)
                
                ##zzz is set to true
                ##code will jump to else statement next time it loops through
                zzz <- TRUE
            
                }
          
          else{
                ##filters by users and activities
                xtidy <- filter(bigset, users == i & activities == z)
            
                ##slices off the firts three columsn of the data set
                ##these are the information columns and are saved as xtidyA
                xtidyA <- select(xtidy, 1:3)
            
                ##the first row of the dataset is sliced and saved as xtidtA
                xtidyA <- xtidyA[1,]
            
                ##slices off the remaining 66 numereic columns and saves as xtidyB
                xtidyB <- select(xtidy, 4:69)
            
                ##using apply the mean is taken across all 66 columns
                xtidyB <- t(apply(xtidyB, 2, mean))
            
                ##for the sake of clarity only the first 4 significant digits are kept
                xtidyB <- round(xtidyB, 4)
            
                ##xtidayA and xtidyB are merged using cbind() to form tidyB dataset
                tidyB <- cbind(xtidyA, xtidyB)
         
                ##tidy and tidyB datasets are merged using rbind
                ##this forms our final tidy dataset
                tidy <- rbind(tidy, tidyB)
                
                
            
              }
          
          }
      
      }


colnames(tidy) <- clean_names


write.table(tidy, file ="tidy_dataset.txt", sep = "\t", row.names = FALSE, eol = "\n\r")

##FIN

## CODEBOOK for run_analysis.R
===========================================================
##Getting and Cleaning Data Assignment 
###Robert Ben Parkinson
###Submitted on 26-Dec-2015

=============================================================
##Dimensions

The tidy_data.txt data frame comprised of 180 rows and 69 columns. The tidy_data data set is broken down in the average mean and standard deviation  for 66 different measurements based on the 30 users and the six activities found in the original Human Activity Recognition Using Smartphones Data set. 

============================================================
##Variables (column names)

[1]"users"               ##users 1 to 30

[2]"activities"          ##"WALKING", "UPSTAIRS", "DOWNSTAIRS", "SITTING", "STANDING", "LAYING"

[3]"testtrain"           ## TEST OR TRAIN based on the two original data sets that were merged.

columns
[4:69]                  ##names simplified using the following legend
                          "t" = "test"
                          "f" = "force"
                          "B" = "Body"
                          "G" = "Gravity"
                          "-A-" = "Acc"
                          "-G-" = "Gyro"
                          "-J-" = "Jerk"
                          
                          
..* [4] "tB-A-mean-X" 
..* [5] "tB-A-mean-Y" 
..* [6] "tB-A-mean-Z"
..* [7] "tB-A-std-X" 
..* [8] "tG-A-mean-X" 
..* [9] "tG-A-mean-Y" 
..* [10] "tG-A-mean-Z" 
..* [11]"tG-A-std-X" 
..* [12]"tG-A-std-Y" 
..* [13]"tG-A-std-Z" 
..* [14]"tB-AJ-mean-X" 
..* [15]"tB-AJ-mean-Y" 
..* [16]"tB-AJ-mean-Z"
..* [17]"tB-AJ-std-X" 
..* [18]"tB-AJ-std-Y" 
..* [19]"tB-AJ-std-Z" 
..* [20]"tB-G-mean-X" 
..* [21]"tB-G-mean-Y" 
..* [22]"tB-G-mean-Z"
..* [23]"tB-G-std-X" 
..* [24]"tB-G-std-Y" 
..* [25]"tB-G-std-Z" 
..* [26]"tB-GJ-mean-X" 
..* [27]"tB-GJ-mean-Y" 
..* [28]"tB-GJ-mean-Z"
..* [29]"tB-GJ-std-X" 
..* [30]"tB-GJ-std-Y" 
..* [31]"tB-GJ-std-Z" 
..* [32]"tB-AM-mean" 
..* [33]"tB-AM-std" 
..* [34]"tG-AM-mean"
..* [35]"tG-AM-std" 
..* [36]"tB-AJM-mean" 
..* [37]"tB-AJM-std" 
..* [38]"tB-GM-mean" 
..* [39]"tB-GM-std" 
..* [40]"tB-GJM-mean"
..* [41]"tB-GJM-std" 
..* [42]"fB-A-mean-X" 
..* [43]"fB-A-mean-Y" 
..* [44]"fB-A-mean-Z" 
..* [45]"fB-A-std-X" 
..* [46]"fB-A-std-Y"
..* [47]"fB-A-std-Z" 
..* [48]"fB-AJ-mean-X" 
..* [49]"fB-AJ-mean-Y" 
..* [50]"fB-AJ-mean-Z" 
..* [51]"fB-AJ-std-X" 
..* [52]"fB-AJ-std-Y"
..* [53]"fB-AJ-std-Z" 
..* [54]"fB-G-mean-X" 
..* [55]"fB-G-mean-Y"
..* [56]"fB-G-mean-Z" 
..* [57]"fB-G-std-X" 
..* [58]"fB-G-std-Y"
..* [59]"fB-G-std-Z" 
..* [60]"fB-AM-mean" 
..* [61]"fB-AM-std" 
..* [62]"fBB_AJM-mean" 
..* [63]"fBB_AJM-std" 
..* [65]"fBB_GM-mean"
..* [67]"fBB_GM-std"
..* [68]"fBB_GJM-mean"
..* [69]"fBB_GJM-std"


==========================================================
##Instructions
##Please see run_analysis.R

1. Import the six primary data frames in the TRAIN and TEST files. Save data sets as t1 to t6. 
2. Import in the column names from features.txt file. Save to features.
3. Install and open the dplyr library. 
4. Ensure that the features table is in a data frame
5. Starting with the TRAIN file we will need to build the first big training data set that we we will later merge with the TEST data set. 
..1. Save the subject_train file (t1) as bigset_train
..2. Rename the first column to "users"
..3. Add the Column named "testtrain" and add the variable "TRAIN"
..4. Add readable column names to the X_train files (t2) from the features.txt file
..5. The standard deviation and mean columns as separated out and placed into a vector called Stand_mean 
..6. The number references are replaced in the y_train file (t3) with readable names     
..7. The y-train column (t3) is renamed "activities"
..8. The bigset_train, t2, and t3 data sets are combined into bigset_train data set
6. Now starting with the Test files
..1.Save the subject_test (t4) bigset_test
..2. Rename the first column to "users"
..3. Add the Column named "testtrain" and add the variable "TEST"
..4. Add readable column names to the X_test files (t5) from the features.txt file
..5. The standard deviation and mean columns as separated out and placed into a vector called Stand_mean 
..6. The number references are replaced in the y_test file (t5) with readable names     
..7. The y-test column (t6) is renamed "activities"
..8. The bigset_test, t4, and t5 data sets are combined into bigset_test data set
7. The bigset_train and bigset_test sets are merged together to form "bigset""
8. bigset is reordered to move the activities column to the front 
..*.c(1, 69, 2:68)
9. Any "na" are removed
10. A simplified set of test names are created
..*. mainly done to make the text file output look nicer
11. A double loop is set up to get the mean for each user for each activity
..1. The first runs through the 30 users in the group
..2. The it runs through the six the six activities found in the study 
12. The bigset is sliced into two data sets.
..1. The first three information columns are sliced off and saved as xtidyA
..2. The remaining 66 numeric columns and saves as xtidyB
..3. Using apply() the mean is taken across all 66 columns
..4. For the sake of clarity only the first 4 digits are kept
..5. xtidayA and xtidyB are merged using cbind() to form tidy data set
13. After looping through 179 more times the results are stitched together into the tidy data set. 
14. The tidy data set is written to the file "tidy_data set.txt"
15. Much rejoicing is had by all. 

##FIN
 
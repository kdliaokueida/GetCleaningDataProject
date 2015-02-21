## README.md 
### Course Project in Getting and Cleaning Data
### Scripts Explanation

*There are many comments I left in the .R file, and I will still try to explain most of the anaylsis flow in this markdown file.

*Most of the work was implemented with dplyr package, hence the dplyr package was loaded at the very beginning.

*Then the train data (X, Y, subject) and test data (X, Y, subject) were loaded, yet the files in every "Inertial Signals folder" were excluded due to the lack of mean and std measurement.

*A string vector called act_lb was created to substitute for the activity number.

*Names each of the measurements according to feature[,2], the activity label to "act", and the subject to "subject".

*Check if any subject perticipated both in train and test. Then combine the test data and train data with cbind().

*In order to extracts only the measurements on the mean and standard deviation for each measurement, I used grep to find measurements including either "mean()" or "std()".

*Later defined a function "nameact" to replace the activity number with appropriate labels.

*Finally, group the data by "subject" and act, then find the mean of each measurement.
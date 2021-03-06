# CodeBook

The run analysis Script contains all data transformations after the data was downloaded to the working directory. 

The input is described in the README.txt of the data - including the various test and train files , the varios features and labels. 
The output tidy DS is the mean of all the std/mean features per subject & actibity. 
To make it tidy, each row is uniquely identified by the combination of subject & activity.


## Files used

The dataset includes multiple files, these are the ones Used: 

* Features.txt
* activity_labels.txt
* train\X_train.txt
* train\subject_train.txt
* train\y_train.txt
* test\X_test.txt
* test\subject_test.txt
* test\y_test.txt

Detailed information about the files and features,  including units and measures is available in README.txt and features_info.txt.

## Steps In the Run Analysis Script:

1. Read the train Dataset (feature, labels - as activity and subject) from the train dir in the data
2. Read the test Dataset (feature, labels  as activity and subject) from the test dir in the data
3. Create the merged data set
4. Read Features and prepare them in an R griendly format
5. label the merged data set with the features
6. Select only Std & Mean features
7. Read the labels to a factor and replace the activity ids with the name
8. prepare the tidy DS by aggregating the DS by subject_activity And returning the mean function on each group
9. Save the tidy DS to tidy.txt in the working directory


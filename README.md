# Getting and Cleaning Data Project
Project repository for Coursera's Getting and Cleaning Data course

This is the project submission for the Getting and Cleaning Data course. The run_analysis.R script does the following:

- Loads reshape2 library used to generate tidy data set
- Download the dataset:
- Unzip the dataset:
- Loads the activity labels and features
- Extracts only the measurements on the mean and standard deviation for each measurement
- Loads the training and test datasets
- Creates one dataset (Merge datasets) and add the labels
- Turn activities & subjects into factors
- Melt data to make it tall and skinny with expected data (creates tidy dataset)
- Write reshaped data (tidy data) to the tidy_data_set.txt file

Included files:
- README.md
- run_analysis.R
- tidy_data_set.txt
- CookBook.md

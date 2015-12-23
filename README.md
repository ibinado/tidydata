# Getting and Cleaning Data Course Project

To clean the data, just run the *run_analysis.R* script. It

* downloads the raw data if it is not already downloaded
* loads the raw data into a number of data.tables
* cleans the data to generate a tidy data set
* summarizes the tidy data set
* writes out that summarized tidy data set to the *wearable.txt* file.

For details of the tidy data set, please refer to the
[CodeBook](https://github.com/ibinado/tidydata/blob/master/CodeBook.md).  
For details of the script, please refer to the comments in the
[script](https://github.com/ibinado/tidydata/blob/master/run_analysis.R).  
You can load the tidy data with:

```{r}
wearable <- read.table('wearable.txt', header=TRUE)
```

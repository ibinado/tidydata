library(data.table)

zipfile <- 'wearable.zip'
tidyfile <- 'wearable.txt'

# Download the data file if it's not already there.
if (!file.exists(zipfile)) {
  download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip',
                zipfile, method='curl')
}

# Reads an individual data file from the zip archive.
# Arguments:
#   The components of the file name.
# Returns:
#   The data file parsed into a data.table with attribute 'source' containing the
#   path from which the file was read.
getData <- function(...) {
  basedir <- 'UCI HAR Dataset'
  path <- file.path(basedir, ...)
  con <- unz(zipfile, path)
  d <- fread(paste(readLines(con), collapse='\n'))
  close(con)
  attr(d, 'source') <- paste(zipfile, path, sep=':')
  return(d)
}

# Read in labels.
activity_labels <- getData('activity_labels.txt')
feature_labels <- getData('features.txt')

# Read in test and train data sets.
data = list(test=NULL, train=NULL)
for (set in names(data)) {
  data[[set]] <- list(
    subject = getData(set, paste0('subject_', set, '.txt')),
    feature = getData(set, paste0('X_', set, '.txt')),
    activity = getData(set, paste0('y_', set, '.txt'))
  )
}

# Check internal consistency of data read from different files.
## Labels need to have two columns.
if (ncol(activity_labels) != 2) {
  stop(paste('invalid activity labels', attr(activity_labels, 'source')))
}
if (ncol(feature_labels) != 2) {
  stop(paste('invalid feature labels', attr(feature_labels, 'source')))
}
for (set in names(data)) {
  ## Subject and activity must have one column.
  if (ncol(data[[set]]$subject) != 1) {
    stop(paste('invalid subject size for data set', set,
               attr(data[[set]]$subject, 'source')))
  }
  if (ncol(data[[set]]$activity) != 1) {
    stop(paste('invalid activity size for data set', set,
               attr(data[[set]]$activity, 'source')))
  }
  ## Feature must have the same number of columns as feature_label has rows.
  if (ncol(data[[set]]$feature) != nrow(feature_labels)) {
    stop(paste('invalid feature size for data set', set,
               attr(data[[set]]$feature, 'source')))
  }
  ## Each activity must have a corresponding label.
  if (sum(!data[[set]]$activity$V1 %in% activity_labels$V1) != 0) {
    stop(paste('invalid activities for data set', set,
               attr(data[[set]]$activity, 'source')))
  }
}

# 1) Merge train and test data sets.
for (name in names(data$test)) {
  data$all[[name]] <- rbind(data$test[[name]], data$train[[name]])
}
# Prepare cleaned up data for export.
tidy <- data$all$feature
# Set feature column names from feature labels.
names(tidy) <- feature_labels$V2
# 2) Extract only the measurements on the mean and standard deviation.
tidy <- tidy[, grep('-(mean|std)[(]', names(tidy)), with=FALSE]
# 4) Appropriately label the data set with descriptive variable names.
# * remove parenthesis from variable names
# * fix typo in data: BodyBody -> Body
# * lowercase names
# (for naming rules see 04_01_editingTextVariables last slide)
names(tidy) <- tolower(gsub('BodyBody', 'Body', gsub('[()]', '', names(tidy))))
names <- names(tidy)

# Add subject and activity columns to cleaned up data.
tidy$subject <- data$all$subject$V1
# 3) Use descriptive activity names to name the activities in the data set.
# Convert activities into appropriately labeled factor.
tidy$activity <- factor(data$all$activity$V1,
                        levels=activity_labels$V1,
                        labels=activity_labels$V2)
# Move subject and activity columns to front and sort by them.
setcolorder(tidy, c('subject', 'activity', names))
tidy <- tidy[order(subject, activity)]

# 5) Compute average of each variable for each activity and each subject.
summarized.tidy <- tidy[, lapply(.SD, mean), by=.(subject, activity)]

write.table(summarized.tidy, tidyfile, row.name=FALSE)

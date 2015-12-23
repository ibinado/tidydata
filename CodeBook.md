# Code Book for Tidy Wearable Data Set

For the description of the experiment and variables provided in the raw data set, please refer to the documentation in the original data (included in this repository for reference):

* README.txt: Overall experiment and raw data layout.
* features_info.txt: Description of the features.

## Data Cleanup

To generate the tidy data set (R variable *tidy*), *run_analysis.R* performs the following transformations on the raw data:

* The test and training data sets are merged into a single data set.
* Of the features in the raw data set, only the mean and standard deviation variables, i.e. those with *mean()* or *std()* in their original feature names are kept, all others are dropped. Note also that the original time-series data from which the features in the raw data set were computed are not part of the tidy data set.
* Feature names are cleaned up by dropping the *()* characters and converting them to all lower case.
* The *activity* variable is converted from an integer representation in the raw data set to a factor with appropriate activity names.
* The data set is sorted by subject and activity.

To generate the summarized tidy data set (R variable *summarized.tidy*) the mean of every feature is computed for every combination of subject and activity. This is the data set that is written to the *wearable.txt* file

# Variables

The following definitions are used in variable naming below:

* **acc**: linear acceleration as measured by the accelerometer.
* **gyro**: angular velocity as measured by the gyroscope.
* **x**, **y**, **z**: 3-axis components of the respective measuremnts.
* **mag**: magnitute computed as Euclidean norm of 3-axis components.
* **jerk**: jerk signal computed as time derivative of the corresponding variable.
* **mean**: mean of the respective measurements.
* **std**: standard deviation of the respective measurements.
* **t** prefix: time-domain signal.
* **f** prefix: frequency-domain signal.

Description of individual variables:

* **subject**:
  Test subject number, 1..30.
* **activity**:
  Activity string (as factor), one of WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING.
* **tbodyacc-mean-x**, **tbodyacc-mean-y**, **tbodyacc-mean-z**, **tbodyacc-std-x**, **tbodyacc-std-y**, **tbodyacc-std-z**: 
  Time domain body accelleration, normalized to [-1,1].
* **tgravityacc-mean-x**, **tgravityacc-mean-y**, **tgravityacc-mean-z**, **tgravityacc-std-x**, **tgravityacc-std-y**, **tgravityacc-std-z**: 
  Time domain gravity accelleration, normalized to [-1,1].
* **tbodyaccjerk-mean-x**, **tbodyaccjerk-mean-y**, **tbodyaccjerk-mean-z**, **tbodyaccjerk-std-x**, **tbodyaccjerk-std-y**, **tbodyaccjerk-std-z**: 
  Time domain body accelleration jerk, normalized to [-1,1].
* **tbodygyro-mean-x**, **tbodygyro-mean-y**, **tbodygyro-mean-z**, **tbodygyro-std-x**, **tbodygyro-std-y**, **tbodygyro-std-z**: 
  Time domain body angular velocity, normalized to [-1,1].
* **tbodygyrojerk-mean-x**, **tbodygyrojerk-mean-y**, **tbodygyrojerk-mean-z**, **tbodygyrojerk-std-x**, **tbodygyrojerk-std-y**, **tbodygyrojerk-std-z**: 
  Time domain body angular velocity jerk, normalized to [-1,1].
* **tbodyaccmag-mean**, **tbodyaccmag-std**: 
  Time domain body accelleration magnitude, normalized to [-1,1].
* **tgravityaccmag-mean**, **tgravityaccmag-std**: 
  Time domain gravity accelleration magnitude, normalized to [-1,1].
* **tbodyaccjerkmag-mean**, **tbodyaccjerkmag-std**: 
  Time domain body accelleration jerk magnitude, normalized to [-1,1].
* **tbodygyromag-mean**, **tbodygyromag-std**: 
  Time domain body angular velocity magnitude, normalized to [-1,1].
* **tbodygyrojerkmag-mean**, **tbodygyrojerkmag-std**: 
  Time domain body angular velocity jerk magnitude, normalized to [-1,1].
* **fbodyacc-mean-x**, **fbodyacc-mean-y**, **fbodyacc-mean-z**, **fbodyacc-std-x**, **fbodyacc-std-y**, **fbodyacc-std-z**: 
  Frequency domain body accelleration, normalized to [-1,1].
* **fbodyaccjerk-mean-x**, **fbodyaccjerk-mean-y**, **fbodyaccjerk-mean-z**, **fbodyaccjerk-std-x**, **fbodyaccjerk-std-y**, **fbodyaccjerk-std-z**: 
  Frequency domain body accelleration jerk, normalized to [-1,1].
* **fbodygyro-mean-x**, **fbodygyro-mean-y**, **fbodygyro-mean-z**, **fbodygyro-std-x**, **fbodygyro-std-y**, **fbodygyro-std-z**: 
  Frequency domain body angular velocity, normalized to [-1,1].
* **fbodyaccmag-mean**, **fbodyaccmag-std**: 
  Frequency domain body accelleration magnitude, normalized to [-1,1].
* **fbodyaccjerkmag-mean**, **fbodyaccjerkmag-std**: 
  Frequency domain body accelleration jerk magnitude, normalized to [-1,1].
* **fbodygyromag-mean**, **fbodygyromag-std**: 
  Frequency domain body angular velocity magnitude, normalized to [-1,1].
* **fbodygyrojerkmag-mean**, **fbodygyrojerkmag-std**: 
  Frequency domain body angular velocity jerk magnitude, normalized to [-1,1].

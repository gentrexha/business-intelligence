# Notes/Report

## A) Dataset

### (1) Select a data set

### (2) Register the dataset & Analyze the characteristics of the dataset

Analysis of the dataset can be found in `../notebooks/Analysis.ipynb`

## B) Classification: Analysis of Train/Test Set Splits, Performance and Parameters

### (1) Select two algorithms or two platforms:

* SVC
* RandomForestClassifier

### (2) Preprocessing

As mentioned on [TUWEL here](https://tuwel.tuwien.ac.at/mod/forum/discuss.php?d=155410#p400153)
there's no need to perform unnecessary preprocessing unless explicitly asked to do so (e.g. in task B-4b).

### (3) Subsampling

Not needed.

### (4) Training & Testing

#### a. Parameters

#### b. Scaling

#### c. Training / test set splits

### Questions

Summarize the results while focusing on the following questions:

a. What trends do you observe in each set of experiments?

b. How easy was it to interpret the algorithm and its performance?

c. Which classes are most frequently mixed-up? (and why?)

d. What parameter settings cause performance changes?

e. Do both algorithms (or two system environments, i.e. any pairing of
Spark/MLlib vs WEKA vs Scikit-Learn, if you chose to work on one algorithm
only) show the same behavior in performance, performance degradation /
robustness against
	i. smaller and larger training set sizes?
	ii. variations in parameter settings?

f. Did you observe or can you force and document characteristics such as over-
learning?

g. How does the performance change with different amounts of training data
being available? What are the best scalings (per attribute / per vector) and
why?

## C

## D
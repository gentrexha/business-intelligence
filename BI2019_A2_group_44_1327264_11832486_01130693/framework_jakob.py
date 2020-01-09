# %% Imports
import numpy as np
import pandas as pd
from pathlib import Path
from sklearn.svm import SVC
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split, GridSearchCV
from sklearn.preprocessing import StandardScaler, MinMaxScaler, Normalizer
from sklearn.impute import SimpleImputer
from sklearn.pipeline import Pipeline

# %% Configuration options
np.random.seed(0)

root_path = Path(__file__).resolve().parents[0]
data_path = root_path / 'data_jakob.csv'

# %% Read the data
full_df = pd.read_csv(
    data_path,
)

full_x = full_df.drop(columns='class').values
full_y = full_df['class'].values.astype(int)


# %% Pipeline creation function
def make_pipe(scaler, classifier):
    steps = [
        [
            'scaler',
            scaler
        ],
        [
            'classifier',
            classifier
        ]
    ]

    return Pipeline(steps)


# %% Task B 4 a
# Try different parameters
classifiers = [
    SVC(),
    RandomForestClassifier(),
]

# TODO: Create reasonable parameter grids
param_grids = {
    "SVC": {},
    "RandomForestClassifier": {},
}

for classifier in classifiers:
    # Construct the full classification pipeline
    pipe = make_pipe(
        StandardScaler(),
        classifier
    )

    # Create the parameter grid for the classifier
    # Because the classifiers are part of the pipeline their parameter names
    # have to be prefixed with their pipeline name
    grid = param_grids[type(classifier).__name__]
    grid = {
        'classifier__' + k: v for k, v in grid.items()
    }

    # Try different parameters
    gs = GridSearchCV(
        pipe,
        param_grid=grid,
        cv=10
    )
    gs.fit(full_x, full_y)

    # Evaluate
    # TODO

# %% Task B 4 b
# Try different scaling methods

# TODO: Apply the best parameters from above to the classifiers
best_classifiers = [
    SVC(),
    RandomForestClassifier(),
]

scalers = [
    StandardScaler(),
    MinMaxScaler(),
    Normalizer()
]

for classifier in classifiers:
    for scaler in scalers:
        # Construct the full classification pipeline
        pipe = make_pipe(
            scaler,
            classifier
        )

        # Train the pipeline
        pipe.fit(full_x, full_y)

        # Evaluate
        # TODO
        is_best_scaler = True  # TODO

# %% Task B 4 c
# Try different train/test splits

# TODO: Apply the best scalers from above
best_pipelines = [
    make_pipe(StandardScaler(), best_classifiers[0]),
    make_pipe(StandardScaler(), best_classifiers[1]),
]

for pipe in best_pipelines:
    for train_percentage in range(5, 105, 10):
        # Create the train/test sets
        train_x, test_x, train_y, test_y = train_test_split(
            full_x, full_y,
            train_size=train_percentage / 100,
            stratify=full_y
        )

        # Train the pipeline
        pipe.fit(train_x, train_y)

        # Evaluate
        # TODO

# %% Task C 2
# Create new datasets with some values being NaNs

# Attributes with high/low information gain
# TODO: Select proper ones. The current ones are just placeholders
high_gain_attr = full_df.columns[0]
low_gain_attr = full_df.columns[1]

frac_nans_few = 0.02
frac_nans_many = 0.2


def insert_nans_attr(df, attr, frac):
    df = df.copy()
    mask = np.random.random(size=len(df)) <= frac
    attr_index = list(full_df.columns).index(attr)
    df[:, attr_index][mask] = np.nan
    return df


def insert_nans(df, frac):
    df = df.copy()
    mask = np.random.random(size=df.shape) <= frac
    df[mask] = np.nan
    return df


x_low_gain_few = insert_nans_attr(full_x, low_gain_attr, frac_nans_few)
x_low_gain_many = insert_nans_attr(full_x, low_gain_attr, frac_nans_many)
x_high_gain_few = insert_nans_attr(full_x, high_gain_attr, frac_nans_few)
x_high_gain_many = insert_nans_attr(full_x, high_gain_attr, frac_nans_many)

x_all_attrs_few = insert_nans(full_x, frac_nans_few)
x_all_attrs_many = insert_nans(full_x, frac_nans_many)


# %% Task C 3 & 4
# Imputation strategies
# Some imputations cannot be implemented as transformers.
# These functions preprocess the dataset, then return (x, y, preprocess_transformer).
# The transformer may be `None`.
def impute_drop_nans(x, y):
    mask = np.isnan(x)
    mask = np.any(mask, axis=1)
    mask = np.logical_not(mask)

    return x[mask, :], y[mask], None


def impute_means(x, y):
    imputer = SimpleImputer()
    return x, y, imputer


def impute_means_per_class(x, y):
    # Find all classes in the dataset
    classes = np.unique(y)

    # Impute the values per class
    batches_x = []
    batches_y = []
    for cls in classes:
        mask = y == cls
        batch_y = y[mask]
        batch_x = x[mask, :]

        imputer = SimpleImputer()
        batch_x = imputer.fit_transform(batch_x)

        batches_y.append(batch_y)
        batches_x.append(batch_x)

    # Combine the batches and return the result
    x = np.concatenate(batches_x, axis=0)
    y = np.concatenate(batches_y, axis=0)
    return x, y, None


impute_strategies = [
    impute_drop_nans,
    impute_means,
    impute_means_per_class
]

for strategy in impute_strategies:
    # Run the strategy. This preprocesses the data and returns an imputer (or `None`)
    x, y, imputer = strategy(full_x, full_y)

    # Create the full pipeline
    raise NotImplementedError  # TODO
    pipe = ...

    # Train the pipeline
    pipe.fit(x, y)

    # Evaluate
    # TODO

# %%


# %%

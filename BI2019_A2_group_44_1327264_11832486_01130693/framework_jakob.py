# %% Imports
import numpy as np
import pandas as pd
import logging
from pathlib import Path
from sklearn.svm import SVC
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split, GridSearchCV
from sklearn.preprocessing import StandardScaler, MinMaxScaler, Normalizer, RobustScaler
from sklearn.impute import SimpleImputer
from sklearn.pipeline import Pipeline
from sklearn_evaluation import plot
from sklearn.metrics import classification_report


# %% Configuration options
np.random.seed(0)

root_path = Path(__file__).resolve().parents[0]
data_path = root_path / 'data_gent.csv'

log_fmt = '%(asctime)s - %(name)s - %(levelname)s - %(message)s'
logging.basicConfig(level=logging.INFO, format=log_fmt)
logger = logging.getLogger(__name__)

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

# TODO: Discuss parameter grids
param_grids = {
    "SVC": {
        'C':[1,10,100,1000],
        'gamma':[1,0.1,0.001,0.0001], 
        'kernel':['linear','rbf']
    },
    "RandomForestClassifier": {
        'bootstrap': [True],
        'max_depth': [80, 90, 100, 110],
        'max_features': [2, 3],
        'min_samples_leaf': [3, 4, 5],
        'min_samples_split': [8, 10, 12],
        'n_estimators': [100, 200, 300, 1000],
        'criterion': ['gini', 'entropy'],
    },
}

# param_grids = {  # For development purposes
#     "SVC": {
#         'C':[1,10,100],
#         'gamma':[1,0.1], 
#         'kernel':['linear','rbf'],
#     },
#     "RandomForestClassifier" : {
#         'n_estimators': [100, 200, 300],
#         'criterion': ['gini', 'entropy'],      
#     },
# }

best_params = {}
grid_scores = {}
df = pd.DataFrame(columns=["classifier", "params", "mean_fit_time", "mean_score_time", "mean_test_score"])

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
        cv=10,
        n_jobs=-1,
        verbose=2
    )
    logger.info('Fitting GridSearchCV with Classfier: {}'
        .format(type(classifier).__name__))
    gs.fit(full_x, full_y)

    # Store results
    grid_scores.update({type(classifier).__name__: gs.cv_results_})
    best_params.update({type(classifier).__name__: gs.best_params_})

    df_grid_scores = pd.DataFrame.from_dict(grid_scores[type(classifier).__name__])
    df_grid_scores["classifier"] = type(classifier).__name__
    df_grid_scores = df_grid_scores[["classifier", "params", "mean_fit_time", "mean_score_time", "mean_test_score"]]
    df = df.append(df_grid_scores)

df.to_csv(root_path / "reports/classifier_selection.csv", index=False)
#%% Evaluation
# The selected hyperparameters for the RandomForestClassifier didn't prove themselves
# useful, for atleast showing differences between iterations. There's very little 
# difference in performance between different parameter sets. Which is proven
# by the variance calculation below.
print("variance of 'mean_test_score' arr results : {}".format( 
        np.var(grid_scores.get("RandomForestClassifier", "")["mean_test_score"])
    )
) 

#%% Visualizations
# kernel: linear
ax = plot.grid_search(grid_scores.get("SVC", ""), change=('classifier__C', 'classifier__gamma'),
    subset={'classifier__kernel': "linear"})
fig = ax.get_figure()
fig.savefig(root_path / 'reports/figures/svc__linear.png')
fig.clear()

# kernel: rbf
ax = plot.grid_search(grid_scores.get("SVC", ""), change=('classifier__C', 'classifier__gamma'),
    subset={'classifier__kernel': "rbf"})
fig = ax.get_figure()
fig.savefig(root_path / 'reports/figures/svc__rbf.png')
fig.clear()

# differences between kernels
ax = plot.grid_search(grid_scores.get("SVC", ""), change='classifier__kernel', kind='bar')
fig = ax.get_figure()
fig.set_figheight(7)
fig.set_figwidth(15)
fig.savefig(root_path / 'reports/figures/svc__kernel_difference.png')
fig.clear()
# %% Task B 4 b
# Try different scaling methods

best_classifiers = [
    SVC(),
    RandomForestClassifier(),
]

scalers = [
    StandardScaler(),
    MinMaxScaler(),
    Normalizer(),
    RobustScaler(),
]

best_scaler = {}

for classifier in classifiers:
    best_scaler[classifier]={}
    for scaler in scalers:
        # Construct the full classification pipeline
        pipe = make_pipe(
            scaler,
            classifier
        )

        # set best params
        pipe.set_params(**best_params[type(classifier).__name__])

        gs = GridSearchCV(
            pipe,
            param_grid={},
            cv=10,
            n_jobs=-1,
            verbose=2
        )

        logger.info('Fitting classfier: {} and scaler: {}'
            .format(type(classifier).__name__, type(scaler).__name__))

        # Train the pipeline
        gs.fit(full_x, full_y)
        
        # Store result
        best_scaler[classifier].update(
            {scaler: gs.cv_results_["mean_test_score"]}
        )
        
# Save all the results in a table or something
df_scalers = pd.concat(
    {
        k: pd.DataFrame.from_dict(v, 'index') for k, v in best_scaler.items()
    }, 
    axis=0
)


# Store and evaluate
df_scalers = df_scalers.reset_index()
df_scalers["level_0"] = df_scalers["level_0"].apply(lambda x: str(x)[0:str(x).find("(")])
df_scalers["level_1"] = df_scalers["level_1"].apply(lambda x: str(x)[0:str(x).find("(")])
df_scalers.to_csv(root_path / "reports/scaling_selection.csv", index=False, header=["classifier","scaling", "mean_test_score"])

# Find best combination
best_combination = {k:max(v, key=v.get) for k, v in best_scaler.items()}

# %% Task B 4 c
# Try different train/test splits

best_pipelines = []
for key, value in best_combination.items():
    best_pipelines.append(make_pipe(value,key).set_params(**best_params[type(key).__name__]))

df = pd.DataFrame()

for pipe in best_pipelines:
    for train_percentage in range(5, 105, 10):
        # Create the train/test sets
        train_x, test_x, train_y, test_y = train_test_split(
            full_x, full_y,
            train_size=train_percentage / 100,
            stratify=full_y
        )

        logger.info("Fitting {} train_percentage with pipeline {}->{}".format(
            train_percentage, type(pipe[0]).__name__, type(pipe[1]).__name__)
        )
        # Train the pipeline
        pipe.fit(train_x, train_y)
        test_y_pred = pipe.predict(test_x)

        # Evaluate
        report = classification_report(test_y, test_y_pred, output_dict=True)
        df_report = pd.DataFrame(report).transpose()
        df_report["pipeline"] = "{}->{}".format(type(pipe[0]).__name__, type(pipe[1]).__name__)
        df_report["train_percentage"] = train_percentage
        df = pd.concat([df,df_report.reset_index()], ignore_index=True)

# Save all result
df.to_csv(root_path / "reports/train_test_split_selection.csv", index=False)
# Save summary only
df.loc[df["index"] == "accuracy"].reset_index(drop=True)[
    ["pipeline", "train_percentage", "precision"]
].to_csv(
    root_path / "reports/train_test_split_accuracy.csv",
    index=False,
    header=["pipeline", "train_percentage", "accuracy"],
)
#%%
# TODO
# Do a confusion matrix for the best train_percentage split
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

from predictors.metric import Metric
from joblib import load
import time, os

def init(obj):
    obj.model = load("models/iris")
    return

def predict(obj, x, features_names=None):
    predictions = obj.model.predict(x)
    return predictions

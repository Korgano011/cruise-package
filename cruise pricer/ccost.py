import torch
import coremltools as ct
import pandas as pd
from sklearn.linear_model import LinearRegression

data = pd.read_csv("crcost.csv")
model = LinearRegression()

model.fit(data[["flight", "hotel", "nights", "roomType", "excursions"]], data["price"])

coreml_model = ct.converters.sklearn.convert(
model,
input_features=["flight", "hotel", "nights", "roomType", "excursions"],
output_feature_names="price"
)

coreml_model.save("cruisePricer.mlmodel")

print("Model created")

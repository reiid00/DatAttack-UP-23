# Predicting Resources for Civil Protection Emergencies in Portugal

This project aims to predict the quantity of resources needed for every Civil Protection emergency based on the location, the nature of emergency, and time, in Portugal. We used data from 2016, retrieved from the publicly available data collected by The National Emergency and Civil Protection Authority.

## Data Exploration and Preparation

The dataset was pre-processed and submitted to preliminary analysis. We used GPT-4 to condense 88 different natures of emergency into 10 categories. Records with fewer than 100 occurrences and missing values were eliminated. The number of resources required (vehicles and personnel) was found to be imbalanced among the records. Aerial resources were not considered due to insufficient data.

We analyzed the temporal dependencies of the quantity of resources that needed to be allocated. The variable `DataOcorrencia` was divided into `Month`, `Day`, `Weekday`, and `Hour`.

## Regression and Classification Models

We created regression and classification models to predict the number of people and vehicles needed to be allocated for every emergency, with an accuracy of 60% and 78%, respectively.

## Repository Contents

- `data/`: Folder containing the dataset from The National Emergency and Civil Protection Authority.
- `images/`: Folder containing images generated during the data exploration and analysis.
- `README.md`: This file, providing an overview of the project and its contents.
- `predicting_resources.ipynb`: Jupyter Notebook containing the code for data exploration, preparation, and model creation.
- `references.bib`: Bibliography file with relevant sources.

## Dependencies

- Python 3.6 or higher
- pandas
- numpy
- scikit-learn
- matplotlib
- seaborn
- geopandas
- GPT-4
- Jupyter Notebook

## Usage

1. Clone this repository.
2. Install the required dependencies.
3. Open the `predicting_resources.ipynb` Jupyter Notebook and run the cells in order.

## License

This project is licensed under the MIT License.

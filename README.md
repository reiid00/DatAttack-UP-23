# DatAtack-UP-23 -> Predicting Resources for Civil Protection Emergencies in Portugal
## Hackathon Winner 🏆

This project aims to predict the quantity of resources needed for every Civil Protection emergency based on the location, the nature of the emergency, and time, in Portugal. The data used was retrieved from the publicly available data collected by The National Emergency and Civil Protection Authority in 2016. [Protecao Civil GitHub](https://github.com/centraldedados/protecao_civil)

## Data Exploration and Preparation

The dataset underwent pre-processing and preliminary analysis. GPT-4 was used to condense 88 different types of emergency into 10 categories. Records with fewer than 100 occurrences and missing values were eliminated. Aerial resources were not considered due to insufficient data. We also analyzed the temporal dependencies of the quantity of resources that needed to be allocated. The variable `DataOcorrencia` was divided into `Month`, `Day`, `Weekday`, and `Hour`.

## Regression and Classification Models

We created regression and classification models to predict the number of people and vehicles needed to be allocated for every emergency, with an accuracy of 60% and 78%, respectively.

## Repository Contents

- `data/`: Folder containing the dataset from The National Emergency and Civil Protection Authority.
- `media/`: Folder containing images, report, and presentation.
- `models/`: Folder containing research on ML and DL models.
- `pre-process-data-vis/`: Folder containing pre-processing and data visualization files.
- `R-research/`: Folder containing R files that researched the dataset, pre-processed and trained some ML model.

## Dependencies

- Python 3.6 or higher
- pandas
- numpy
- scikit-learn
- matplotlib
- seaborn
- geopandas
- Notebook

## License

This project is licensed under the MIT License.

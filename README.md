# 📊 Analysis of Danmarks Statistik

This project focuses on analyzing various datasets related to Danish statistics, including traffic accidents, demographics of young mothers, and consumer expectations. By utilizing the `dkstat` R package, the analysis aims to provide insights into consumer behavior and social trends in Denmark.

## 🚀 Introduction

This script performs the following steps:

- Loads data from Excel and CSV files containing relevant datasets.
- Retrieves data via the Danish statistics API.
- Transforms the data for meaningful analyses.
- Visualizes results to draw conclusions about the data.

## 📁 Contents

- **UUheld.xlsx**: Excel file containing traffic accident data.
- **alletaps.csv**: CSV file with available tables from the `dkstat` package.
- **dkstat.R**: R script for retrieving and processing traffic accident data.
- **FODPM.R**: R script for analyzing young mothers' data.
- **Forv1.R**: R script for analyzing consumer expectations.
- **util.R**: Utility R script defining functions for data categorization.

## 📊 Data Analysis

The scripts perform the following:

### Loading Data:

- Sets the working directory to the specified folder.
- Loads data from `UUheld.xlsx` using the `readxl` package.
- Retrieves tables from the Danish statistics API and exports them to `alletaps.csv`.

### Data Transformation:

- Constructs filters to retrieve relevant data from the Danish statistics API for various analyses.
- Cleans and reshapes data frames for analysis.
- Transforms age data into categorical variables.

### Visualizations:

- Utilizes `ggplot2` to create visualizations based on aggregated data to illustrate trends.
  
### Estimation of Missing Values:

- Implements logic to estimate missing quarterly data for consumer expectations based on existing values.

## 🛠️ Technologies

- **R**: The analysis environment used for data handling and visualization.
- **readr**: Package used for reading data from CSV files.
- **readxl**: Package used for reading data from Excel files.
- **dkstat**: Package for accessing Danish statistics via an API.
- **ggplot2**: Package used for data visualization.

## 📌 Requirements

- R and RStudio must be installed on your machine.
- The following packages should be installed: `dkstat`, `readr`, `readxl`, `ggplot2`. You can install them by running:

    ```r
    install.packages(c("dkstat", "readr", "readxl", "ggplot2"))
    ```

## 🤝 Contributing

Contributions are welcome! If you have suggestions or improvements, feel free to fork the repository and submit a pull request.

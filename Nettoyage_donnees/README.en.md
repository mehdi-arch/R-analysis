<a href="./README.en.md"><img alt="en" src="https://img.shields.io/badge/lang-en-red.svg"/></a>
<a href="./README.md"><img alt="fr" src="https://img.shields.io/badge/lang-fr-yellow.svg"/></a>
# Yarn Data Analysis

The R script uses the **tidyverse** and **tidytuesdayR** libraries. If they are not installed on your machine, a function will install them at the beginning of the script.

## Objective of the Analysis

The goal was to explore the data from this TidyTuesday dataset, focusing on a stock of yarn with all its characteristics (weight, etc). The issue was the presence of missing values in this dataset. The aim was to preprocess this dataset to have homogeneous data, allowing for the later application of machine learning algorithms (AI). The data here comes from TidyTuesday in the 41st week of 2022.

## Data Exploration

Firstly, we examine the distribution of missing values in the **max_gauge** variable and provide a summary of the missing value rate in other columns.

## Handling Outliers

Outliers are treated with great attention as they can distort any conclusion/algorithm, particularly in the case of **yardage** values. Outliers with zero values are identified and corrected.

## Data Filtering

The data is filtered to exclude null values in **grams** and **yardage**. A new variable **dens** is created by calculating the ratio **grams / yardage**, and another variable **gauge_std** is calculated by the ratio **min_gauge / gauge_divisor**.

## Analysis of the Relationship between dens and gauge_std

A visualization is created to explore the relationship between these two variables. A scatter plot and a linear regression line are plotted to assess the trend.

![Graphical representation of the data](imgs/corr_dens_etalon_gauge_nettoye.png)

## Imputation of Missing Values with a Linear Model

A linear model is fitted to impute missing values in **gauge_std** based on **dens**. The model results are examined, and a new variable **gauge_std_imputed** is created using the model.

## Data Visualization

The last part of the script involves visualizing and comparing the imputed values of **gauge_std** with the actual values using a scatter plot.

![Graphical representation of the final results](imgs/comparaison_data.png)

## Conclusion

This script provides a systematic approach to explore, clean, and analyze yarn data. It particularly emphasizes the imputation of missing values and provides a clear visualization of the relationships between different variables.

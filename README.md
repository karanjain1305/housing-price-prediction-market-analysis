Housing Price Prediction & Market Value Analysis

Overview

Built a housing price prediction and market value analysis project using R, SQL, and Looker Studio. The project predicts home sale prices, evaluates model performance, identifies key price drivers, and visualizes market trends across neighborhoods and property segments.

Tools Used

R  
SQL / SQLite  
Looker Studio  
Google Sheets  
Excel / CSV  

Project Workflow

Cleaned and prepared housing transaction data in R.  
Built linear regression and random forest models to predict sale prices.  
Generated prediction outputs comparing actual vs. predicted sale prices.  
Used SQL to analyze housing market trends, neighborhood prices, property quality, garage capacity, and prediction error.  
Created a Looker Studio dashboard to visualize model results and market value drivers.

Key Metrics

Homes Predicted: 291  
Average Actual Sale Price: $185,607  
Average Predicted Sale Price: $182,339  
Average Prediction Error: $19,900  

Key Insights

Overall quality, living area, neighborhood, garage size, and year built were major drivers of home sale price.  
Predicted prices closely followed actual prices across neighborhoods, showing strong model performance.  
Higher-priced homes showed larger prediction errors compared to lower-priced homes.  
Neighborhood-level differences played a major role in home value variation.

Dashboard Preview

![Housing Price Dashboard](dashboard_screenshot.png)

Files

housing_model.R: R script for cleaning, modeling, predictions, and feature importance.  
Housing_SQL_Queries.sql: SQL queries used for housing market and prediction error analysis.  
Housing_Cleaned.csv: Cleaned housing dataset used for SQL and dashboard analysis.  
Housing_Predictions.csv: Actual vs. predicted sale price output.  
Feature_Importance.csv: Random forest feature importance results.

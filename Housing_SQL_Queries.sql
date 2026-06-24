-- Housing Price Prediction & Market Value Analysis
-- Tools Used: R, SQL, Looker Studio
-- Purpose: Analyze housing prices, neighborhood trends, property value drivers, and prediction errors.


-- 1. Overall housing market summary
SELECT
    COUNT(*) AS Total_Homes,
    ROUND(AVG(SalePrice), 2) AS Avg_SalePrice,
    ROUND(MIN(SalePrice), 2) AS Min_SalePrice,
    ROUND(MAX(SalePrice), 2) AS Max_SalePrice,
    ROUND(AVG(GrLivArea), 2) AS Avg_Living_Area
FROM Homes;


-- 2. Top 10 neighborhoods by average sale price
SELECT
    Neighborhood,
    COUNT(*) AS Total_Homes,
    ROUND(AVG(SalePrice), 2) AS Avg_SalePrice,
    ROUND(AVG(GrLivArea), 2) AS Avg_Living_Area,
    ROUND(AVG(OverallQual), 2) AS Avg_Overall_Quality
FROM Homes
GROUP BY Neighborhood
ORDER BY Avg_SalePrice DESC
LIMIT 10;


-- 3. Sale price by overall quality
SELECT
    OverallQual,
    COUNT(*) AS Total_Homes,
    ROUND(AVG(SalePrice), 2) AS Avg_SalePrice,
    ROUND(AVG(GrLivArea), 2) AS Avg_Living_Area
FROM Homes
GROUP BY OverallQual
ORDER BY OverallQual DESC;


-- 4. Sale price by garage capacity
SELECT
    GarageCars,
    COUNT(*) AS Total_Homes,
    ROUND(AVG(SalePrice), 2) AS Avg_SalePrice,
    ROUND(AVG(GarageArea), 2) AS Avg_Garage_Area
FROM Homes
GROUP BY GarageCars
ORDER BY GarageCars DESC;


-- 5. Prediction accuracy summary
SELECT
    COUNT(*) AS Predicted_Homes,
    ROUND(AVG(Actual_SalePrice), 2) AS Avg_Actual_Price,
    ROUND(AVG(Predicted_SalePrice), 2) AS Avg_Predicted_Price,
    ROUND(AVG(Absolute_Error), 2) AS Avg_Absolute_Error,
    ROUND(MAX(Absolute_Error), 2) AS Max_Absolute_Error
FROM Predictions;


-- 6. Prediction error by price range
SELECT
    Price_Range,
    COUNT(*) AS Total_Homes,
    ROUND(AVG(Actual_SalePrice), 2) AS Avg_Actual_Price,
    ROUND(AVG(Predicted_SalePrice), 2) AS Avg_Predicted_Price,
    ROUND(AVG(Absolute_Error), 2) AS Avg_Absolute_Error
FROM Predictions
GROUP BY Price_Range
ORDER BY Avg_Actual_Price;
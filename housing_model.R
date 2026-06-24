# Housing Price Prediction & Market Value Analysis
# Tools: R, SQL, Looker Studio

library(tidyverse)
library(caret)
library(randomForest)

# Set your project folder
setwd("~/Desktop/Housing_Price_Project")

# Load dataset
housing <- read.csv("train.csv")

# Basic view
str(housing)
summary(housing$SalePrice)

# Select important variables for first model
model_data <- housing %>%
  select(
    SalePrice,
    OverallQual,
    GrLivArea,
    GarageCars,
    GarageArea,
    TotalBsmtSF,
    YearBuilt,
    FullBath,
    BedroomAbvGr,
    LotArea,
    Neighborhood
  ) %>%
  drop_na()

# Convert Neighborhood to factor
model_data$Neighborhood <- as.factor(model_data$Neighborhood)

# Train/test split
set.seed(123)
train_index <- createDataPartition(model_data$SalePrice, p = 0.8, list = FALSE)
train_data <- model_data[train_index, ]
test_data <- model_data[-train_index, ]

# Model 1: Linear Regression
lm_model <- lm(SalePrice ~ ., data = train_data)

lm_predictions <- predict(lm_model, newdata = test_data)

lm_rmse <- RMSE(lm_predictions, test_data$SalePrice)
lm_r2 <- R2(lm_predictions, test_data$SalePrice)

# Model 2: Random Forest
set.seed(123)
rf_model <- randomForest(
  SalePrice ~ .,
  data = train_data,
  ntree = 300,
  importance = TRUE
)

rf_predictions <- predict(rf_model, newdata = test_data)

rf_rmse <- RMSE(rf_predictions, test_data$SalePrice)
rf_r2 <- R2(rf_predictions, test_data$SalePrice)

# Print model results
cat("Linear Regression RMSE:", round(lm_rmse, 2), "\n")
cat("Linear Regression R2:", round(lm_r2, 3), "\n")
cat("Random Forest RMSE:", round(rf_rmse, 2), "\n")
cat("Random Forest R2:", round(rf_r2, 3), "\n")

# Feature importance from Random Forest
importance_df <- as.data.frame(importance(rf_model))
importance_df$Feature <- rownames(importance_df)
importance_df <- importance_df %>%
  arrange(desc(IncNodePurity))

print(importance_df)

# Create prediction output for dashboard
prediction_output <- test_data %>%
  mutate(
    Actual_SalePrice = SalePrice,
    Predicted_SalePrice = round(rf_predictions, 0),
    Prediction_Error = Actual_SalePrice - Predicted_SalePrice,
    Absolute_Error = abs(Prediction_Error),
    Price_Range = case_when(
      Actual_SalePrice < 150000 ~ "Below $150K",
      Actual_SalePrice < 250000 ~ "$150K-$250K",
      Actual_SalePrice < 400000 ~ "$250K-$400K",
      TRUE ~ "$400K+"
    )
  )

# Save cleaned full dataset
housing_cleaned <- housing %>%
  select(
    SalePrice,
    OverallQual,
    GrLivArea,
    GarageCars,
    GarageArea,
    TotalBsmtSF,
    YearBuilt,
    FullBath,
    BedroomAbvGr,
    LotArea,
    Neighborhood
  ) %>%
  drop_na()

write.csv(housing_cleaned, "Housing_Cleaned.csv", row.names = FALSE)
write.csv(prediction_output, "Housing_Predictions.csv", row.names = FALSE)
write.csv(importance_df, "Feature_Importance.csv", row.names = FALSE)

cat("Files saved successfully.\n")
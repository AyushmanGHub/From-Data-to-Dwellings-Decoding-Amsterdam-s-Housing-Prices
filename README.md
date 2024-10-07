# Amsterdam-House-Price-Analysis-and-Prediction

## Abstract
This project aims to analyze and predict **housing prices in Amsterdam** using data from August 2021. The primary goal is to **identify trends affecting housing prices**. By analyzing predictors such as property area, number of rooms, and geographic location, the project will explore relationships through exploratory data analysis (EDA). A predictive model, using statistical and machine learning techniques, will be developed to estimate prices and provide insights into the market.


## Conclusion and Discussion
This project successfully analyzed and predicted housing prices in
Amsterdam by examining a comprehensive dataset from August 2021. Through
univariate, bivariate, and multivariate data analyses, we identified
significant trends and correlations between various predictors such as
area, number of rooms, and geographic location.

\vspace{-2mm}

-   **Rooms and Area vs. Price**: Area and number of rooms are the
    strongest predictors of price. \vspace{0mm}
-   **Rooms and Area**: Rooms and Area are highly correlated
    \vspace{0mm}
-   **Latitude and Longitude vs. Price**: Location plays a role but is
    less influential than area and room count. \vspace{0mm}
-   **Correlation of Variables**: The strong correlation between area,
    rooms, and price suggests a linear relationship, making a linear
    regression model a suitable choice for prediction. Latitude and
    longitude can also be included to improve model accuracy.

The **strong positive correlation** between the `Area` and `Price`, as
well as the moderate correlation with `Rooms`, indicates that a linear
relationship may exist between these variables and house prices. This
suggests that a **linear regression model could provide a solid baseline
for predictions**. Also, other predictors identified during the EDA ,
such as `Longitude` and `Latitude`, can be included as independent
variables in the linear model. These features have shown significant
relationships with house prices and are likely to contribute
meaningfully to the model's accuracy.

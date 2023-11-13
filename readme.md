# Popularity of Names in Poland - R Shiny App

This R Shiny application provides a user-friendly interface to explore the popularity of names in Poland. It allows users to interactively view the most popular names by year and plot the frequency of names over time.

## Features

The application has two main tabs:

1. **Most Popular Names by Year**: 
   - Users can select a year between 2000 and 2021.
   - The number of top names to view can be adjusted (between 1 and 30).
   - The application displays a table showing the ranking of top male and female names for the selected year.

2. **Plot Frequency Name**: 
   - Users can select one or more names from a list.
   - Options to choose between absolute counts or per 100k births.
   - The scale of the plot can be adjusted between linear and logarithmic.
   - Generates an interactive plot showing the selected names' frequency over time.

## Data

- The application uses a dataset named `names_edited.csv`, which should contain yearly data for names in Poland, including the count and proportion per 100,000 births.

## Running the Application

1. **Prerequisites**:
   - Ensure you have R and RStudio installed.
   - The following R packages are required: `shiny`, `shinyWidgets`, `plotly`, `dplyr`, `tidyr`, and `glue`.

2. **Starting the App**:
   - Open the `ui.R` and `server.R` files in RStudio.
   - Run the Shiny app by clicking the 'Run App' button or using the `shiny::runApp()` function in the R console.

## Notes

- The application's layout and functionalities are optimized for educational and demonstrative purposes.
- The data should be encoded in UTF-8 to ensure proper handling of special characters.

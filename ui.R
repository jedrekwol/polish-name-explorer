library(shiny)
library(shinyWidgets)
library(plotly)


ui <- fluidPage(
  headerPanel("Popularity of names in Poland"),
  tabsetPanel(
    tabPanel("Most popular names by year",
      fluid = TRUE,
      sidebarLayout(
        sidebarPanel(
          sliderInput("year", "Choose year",
            min = 2000, max = 2021, value = 2005, sep = ""
          ),
          numericInput(
            inputId = "n_obs",
            label = "Number of observations to view:",
            value = 10, min = 1, max = 30
          )
        ),
        mainPanel(
          uiOutput("header"),
          tableOutput("table")
        )
      )
    ),
    tabPanel("Plot frequency name",
      fluid = TRUE,
      sidebarLayout(
        sidebarPanel(
          uiOutput("names_selector"),
          radioGroupButtons("range", "Choose range",
            choices = c("absolute" = "Count", "per 100k births" = "Prop"), justified = TRUE
          ),
          radioGroupButtons("scale", "Choose scale",
            choices = c("linear", "logarithmic" = "log"), justified = TRUE
          ),
        ),
        mainPanel(
          uiOutput("nonames_warning"),
          plotlyOutput("plot")
        )
      )
    )
  )
)

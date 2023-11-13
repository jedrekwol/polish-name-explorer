library(shiny)
library(dplyr)
library(tidyr)
library(plotly)
library(glue)

get_top_n_names <- function(year, n_obs, sex) {
  top_names <- names %>%
    filter(Year == year, Sex == sex) %>%
    select(Name, Count, Prop) %>%
    slice_head(n = n_obs) %>%
    rename(Name = Name, Occurrences = Count, Per_100k_Births = Prop)
  return(top_names)
}

names <- read.csv("data/names_edited.csv", encoding = "UTF-8")
names_by_occurrences <- names %>%
  select(Name, Count) %>%
  group_by(Name) %>%
  summarise(Count = sum(Count)) %>%
  arrange(desc(Count))

server <- shinyServer(function(input, output) {
  
  # Output names selector UI
  output$names_selector <- renderUI({
    multiInput(
      inputId = "names", label = "Choose name:",
      choices = names_by_occurrences$Name,
      selected = "Jakub", width = "350px"
    )
  })
  
  output$table <- renderTable({
    top_names_m <- get_top_n_names(input$year, input$n_obs, "M")
    top_names_f <- get_top_n_names(input$year, input$n_obs, "F")
    top_names <- cbind(Rank = 1:input$n_obs, top_names_m, top_names_f)
    top_names
  })
  
  output$nonames_warning <- renderUI({
    if (length(input$names) == 0) {
      h2(paste("Choose at least one name"))
    }
  })
  
  output$plot <- renderPlotly({
    selected_names <- input$names
    
    names_for_plot <- names %>%
      filter(Name %in% selected_names) %>%
      select(Year, Name, Count, Prop, Sex) %>%
      group_by(Name, Sex) %>%
      complete(Year = full_seq(2000:2021, 1)) %>%
      replace(is.na(.), 0)
    
    names_plot <- ggplot(names_for_plot, aes(
      x = Year, y = eval(as.symbol(input$range)),
      group = Name,
      text = glue("{Name} {min(names_for_plot$Count)} \n {Count} occurrences in {Year} \n {Prop} occurrences per 100k births")
    )) +
      geom_line(aes(color = Name), size = 0.5) +
      theme_classic() +
      labs(x = "Year", y = "occurrences") +
      {if (input$scale == "log") scale_y_continuous(trans = scales::pseudo_log_trans(base = 10))} +
      theme(legend.position = "bottom")
    
    if (length(input$names) > 0) {
      ggplotly(names_plot, tooltip = "text")
    }
  })
  
  output$header <- renderUI({
    h2(glue("The most popular names in Poland in {input$year}"))
  })
  
})

library(shiny)
library(ovalide)
library(ovalideTableSelector)

ui <- fluidPage(
  selectInput("finess", "Finess", c("620100057", "020000063")),
  selectInput("champ", "Champ", c("mco", "psy")),
  selectInput("statut", "Statut", c("dgf", "oqn")),
  selectInput("column_name", "Colonne", LETTERS),
  textOutput("table_selector_return"),
  ovalideTableSelectorUI("selector")
)

server <- function(input, output, session) {
  
  nature <- reactiveVal(NULL)
  column_name <- reactiveVal(NULL)
  finess <- reactiveVal(NULL)
    
  observe({
    nature(ovalide::nature(input$champ, input$statut))
    column_name(input$column_name) 
    finess(input$finess)
  })
  
  table_selector_return <-  ovalideTableSelectorServer("selector",
                                                       finess,
                                                       nature,
                                                       column_name,
                                                       10)
  output$table_selector_return <- renderText({
    as.character(table_selector_return())
  })
}

shinyApp(ui, server)
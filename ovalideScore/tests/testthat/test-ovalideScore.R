library(shiny)
library(ovalideScore)

ui <- fluidPage(
  shiny::selectInput("champ", "Champ", choices = c("mco", "psy")),
  shiny::selectInput("statut", "Statut", choices = c("dgf", "oqn")),
  shiny::textOutput("out"),
  ovalideScoreUI("score")
)

server <- function(input, output, session) {
  
  nature <- reactiveVal(NULL)
  
  observe({
    nature(ovalide::nature(input$champ, input$statut))
  })
  
  out <- ovalideScoreServer("score", nature)
  
  output$out <- shiny::renderText({
    as.character(out())
  })
}

shinyApp(ui, server)
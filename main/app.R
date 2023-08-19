## app.R ##
library(shiny)
library(shinydashboard)
library(main)
library(ovalide)

ui <- dashboardPage(
  dashboardHeader(title = "DILAVO"),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Récap. score", tabName = "scores"),
      selectInput("champ",  "Champ",  c(MCO = "mco",
                                        SSR = "ssr",
                                        HAD = "had",
                                        PSY = "psy")),
      selectInput("statut", "Statut", c(DGF = "dgf",
                                        OQN = "oqn")),
      hr(),
      menuItem("MàJ. données", tabName = "update"),
      selectInput("data", "Données", c("Scores",
                                       "Tables",
                                       "Contacts")),
      hr()
    )
  ),
  dashboardBody(
    tags$head( 
      tags$style(HTML("[data-toggle] { font-size: 24px; }"))
    ),
    tabItems(
      tabItem(tabName = "scores", scoreTabSetUI("tabset")),
      tabItem(tabName = "update", dataUploaderUI("uploader"))
    )
  )
)

server <- function(input, output, session) {
  last_state_file <- "last_state.rds"
  
  if ( fs::file_exists(last_state_file) ) {
    last_state <- readr::read_rds(last_state_file)
    shiny::updateSelectInput(session, "champ", selected = last_state$champ)
    shiny::updateSelectInput(session, "statut", selected = last_state$statut)
    shiny::updateSelectInput(session, "data", selected = last_state$data)
  }
  
  observeEvent(c(input$champ, input$statut, input$data), {
    readr::write_rds(list( champ = input$champ,
                           statut = input$statut,
                           data   = input$data),
                     last_state_file)
  })
  
  
  scoreTabSetServer("tabset", reactive(nature(input$champ, input$statut)))
  dataUploaderServer("uploader",
                     reactive(input$champ),
                     reactive(input$statut),
                     reactive(input$data))
  
  
}

shinyApp(ui, server)

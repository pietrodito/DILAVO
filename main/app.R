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
      tabItem(tabName = "scores",
              scoreTabSetUI("tabset")),
      tabItem(tabName = "update",
              h3("Téléversez le fichier..."),
              actionButton("file", "Parcourir..."),
              uiOutput("what_file_champ"),
              uiOutput("what_file_statut"),
              uiOutput("what_file_data")
              )
    )
  )
)

server <- function(input, output) {
  scoreTabSetServer("tabset",
                                        reactive(nature(input$champ,
                                                                 input$statut)))
  
  output$what_file_champ  <- renderUI({h4(paste("Champ :"  , input$champ))})
  output$what_file_statut <- renderUI({h4(paste("Statut :" , input$statut))})
  output$what_file_data   <- renderUI({h4(paste("Données :", input$data))})
}

shinyApp(ui, server)
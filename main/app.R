## app.R ##
library(shiny)
library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(title = "DILAVO"),
  dashboardSidebar(
    menuItem("Récap. score", tabName = "scores"),
    selectInput("champ",  "Champ",  c(MCO = "mco",
                                      SSR = "ssr",
                                      HAD = "had",
                                      PSY = "psy")),
    selectInput("statut", "Statut", c(DGF = "dgf",
                                      OQN = "oqn")),
    menuItem("MàJ. données", tabName = "update")
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "scores", ovalideScoreTabSet::scoreTabSetUI("tabset")),
      tabItem(tabName = "update", "Work in progress...")
    )
  )
)


server <- function(input, output) {
  ovalideScoreTabSet::scoreTabSetServer("tabset",
                                        reactive(ovalide::nature(input$champ,
                                                                 input$statut)))
}

shinyApp(ui, server)
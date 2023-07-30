library(shiny)
library(ovalideScoreTabSet)

if (interactive()) {

  ui <- fluidPage(
    scoreTabSetUI("sts")
  )

  server <- function(input, output, session) {
    scoreTabSetServer("sts", ovalide::nature("mco", "dgf"))
  }

  shinyApp(ui, server)
}

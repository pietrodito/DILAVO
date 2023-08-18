#' @export
scoreTabSetUI <- function(id) {
  ns <- NS(id)

  tabPanel <- shiny::tabPanel
  uiOutput <- shiny::uiOutput

  shiny::tabsetPanel(
    id = ns("tabSet"),
    shinyjs::useShinyjs(),
    
    
    tabPanel("Score",
             value = "Score", 
             ovalideScoreUI(ns("score"))),
    
    tabPanel("Tableaux", value = "tableSelector", 
             ovalideTableSelectorUI(
               ns("tableSelector"))),
    
    ## Il prend la nature et le nom de table...
    tabPanel("Config." , value = "Config." ,
             tableDesignerUI(ns("conf"), debug = T))
  )
}

#' @export
scoreTabSetServer <- function(id, nature) {
  
  stopifnot(is.reactive(nature))

  moduleServer(id, function(input, output, session) {
    ns <- NS(id)

    r <- reactiveValues()
    
    
    score_server_result <-
      ovalideScoreServer("score", nature)
    

    table_name_in_config <-
      ovalideTableSelectorServer(
        "tableSelector",
        score_server_result$finess,
        score_server_result$etablissement,
        nature,
        score_server_result$column_name,
        score_server_result$cell_value)
                                                                
    
    observe({
        req(table_name_in_config())
        shiny::updateTabsetPanel(session,
                                 "tabset",
                                 selected = "tableSelector")
    })
    
    tableDesignerServer(
      "conf",
      table_name_in_config,
      nature,
      score_server_result$finess)
  })
}


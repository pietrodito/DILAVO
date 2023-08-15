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
             ovalideScore::ovalideScoreUI(ns("score"))),
    
    
    tabPanel("Tableaux", value = "tableSelector", 
             ovalideTableSelector::ovalideTableSelectorUI(
               ns("tableSelector"))),
    
    
    ## Il prend la nature et le nom de table...
    tabPanel("Config." , value = "Config." ,
             ovalideTableDesigner::tableDesignerUI(ns("conf"), debug = T))
  )
}

#' @export
scoreTabSetServer <- function(id, nature) {
  
  stopifnot(is.reactive(nature))

  moduleServer(id, function(input, output, session) {
    ns <- NS(id)

    r <- reactiveValues()
    
    
    score_server_result <-
      ovalideScore::ovalideScoreServer("score", nature)
    

    table_name_in_config <-
      ovalideTableSelector::ovalideTableSelectorServer(
        "tableSelector",
        score_server_result$finess,
        nature,
        score_server_result$column_name,
        score_server_result$cell_value)
                                                                
    
    ovalideTableDesigner::tableDesignerServer(
      "conf",
      table_name_in_config,
      nature,
      score_server_result$finess)
  })
}


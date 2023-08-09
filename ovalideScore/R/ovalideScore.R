#' @export
ovalideScoreUI <- function(id) {
  ns <- NS(id)
  
  DT::DTOutput(ns("score_table"))
}

#' @export
ovalideScoreServer <- function(id, nature) {
  
  stopifnot(shiny::is.reactive(nature))
  
  moduleServer(
    id,
    function(input, output, session) {
      
      r <- reactiveValues()
      
      observe({
        if( ! is.null(nature())) {
          ovalide::load_score(nature())
        }
      })
      
      output$score_table <-
        DT::renderDT(ovalide::score(nature()),
                     rownames = FALSE,
                     selection = list(mode = "single", target = "cell"),
                     options   = list(dom  = "t"     , pageLength = -1))
      
      observe({
        req(input$score_table_cells_selected)
        row <- input$score_table_cells_selected[1]
        r$etablissement <- ovalide::score(nature())[row, 1]
        r$finess <- ovalide::score(nature())[row, 2] |> dplyr::pull(Finess)
        r$column_nb <- input$score_table_cells_selected[2] + 1 #JS: [0, 1, ...] 
        r$column_name <- names(ovalide::score(nature()))[r$column_nb]
        r$cell_value <- ovalide::score(nature())[row, r$column_nb] |> unlist()
      })
      
      reactive({
        list(
          column_nb   = r$column_nb  ,
          column_name = r$column_name,
          cell_value  = r$cell_value , 
          finess      = r$finess
        )
      })
    })
}
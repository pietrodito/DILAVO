#' @export
scoreTabSetUI <- function(id) {
  ns <- NS(id)

  tabPanel <- shiny::tabPanel
  uiOutput <- shiny::uiOutput

  shiny::tabsetPanel(
    id = ns("tabSet"),
    shinyjs::useShinyjs(),
    
    ## TODO faire un module ovalideScore
    ## qui prend en entrée :
    ## + un reactive nature
    ## qui renvoie : 
    
    tabPanel("Score"   , value = "Score"   , uiOutput(ns("score"))),
    
    
    ## TODO faire un module ovalideTables qui prend
    ## en entrée deux reactives :
    ## + un nom de colonne
    ## + une nature
    ## On a besoin d'étendre le package ovalide pour gérer les tables
    ## associées à chaque colonne
    ## il renvoie le nom de table que l'on veut configurer
    tabPanel("Tableaux", value = "Tableaux", uiOutput(ns("tabs" ))),
    
    
    tabPanel("Config." , value = "Config." ,
             ovalideTableDesigner::tableDesignerUI(ns("conf"), debug = T))
  )
}

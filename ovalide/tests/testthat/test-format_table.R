
if (interactive()) {
  library(ovalide)
  library(shiny)
  library(tidyverse)

  read_score_csv_file("tests/testthat/test_data/mco_dgf.csv", nature())
  read_zip_table_file("tests/testthat/test_data/mco.dgf.2023.4.ovalide-tables-as-csv.zip", nature())
  load_ovalide_tables(nature())
  table <- ovalide_tables(nature())[["T1D2RTP_1"]]
  load_score(nature())
  score <- score(nature())
  (finess <- score$Finess)
  names(finess) <- score$Libellé

  (formating <- readr::read_rds("../ovalideTableDesigner/test.rds"))
  format_table(table, formating, finess)
}

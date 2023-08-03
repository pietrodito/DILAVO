#' @export
formatting <- function(selected_columns   = NULL,
                       translated_columns = NULL,
                       filters            = NULL,
                       row_names          = NULL,
                       rows_translated    = NULL,
                       proper_left_col    = NULL) {
  structure(
    list(
      selected_columns   = selected_columns  ,
      translated_columns = translated_columns,
      filters            = filters           ,
      row_names          = row_names         ,
      rows_translated    = rows_translated   ,
      proper_left_col    = proper_left_col   
    ),
    class = "formatting"
  )
}

format_filepath <- function(table_name, nature) {
  paste0(data_save_dir(nature), table_name, ".format")
}

#' @export
write_table_format <- function(table_name, nature, formatting) {
  readr::write_rds(formatting, format_filepath(table_name, nature))
}

#' @export
read_table_format <- function(table_name, nature, formatting) {
  readr::read_rds(format_filepath(table_name, nature))
}
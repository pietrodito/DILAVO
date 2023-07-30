#' Format table
#' @export
format_table <- function(table,
                         finess,
                         selected_columns,
                         translated_columns,
                         filters,
                         row_names,
                         rows_translated,
                         proper_left_col) {
  (
    table
    %>% filter_on_finess(finess)
    %>% rename_1st_col_rows(proper_left_col, selected_columns,
                            row_names, rows_translated)
    %>% apply_all_filters(filters)
    %>% select_columns(selected_columns)
    %>% rename_cols(translated_columns)
    %>% format_percentage_columns()
    %>% arrange_marked_column()
  )
}

filter_on_finess <- function(result, finess) {
    dplyr::filter(result, finess_comp == finess)
}

arrange_marked_column <- function(df) {
  count_consecutive_stars <- function(character) {
    (
      character
      |> stringr::str_extract("[*]+")
      |> stringr::str_length()
    ) -> stars_count
    names(stars_count) <- character
    names(sort(stars_count))
  }
  column_to_arrange_order <- count_consecutive_stars(names(df))
  dplyr::arrange(df, dplyr::across(dplyr::all_of(column_to_arrange_order),
                                   dplyr::desc))
}

rename_1st_col_rows <- function(result,
                                proper_left_col,
                                selected_columns,
                                row_names,
                                rows_translated) {
  if (proper_left_col && length(rows_translated) > 0) {
    first_col_name <- selected_columns[1]
    mapping <- tibble(row_names, rows_translated)
    
    join_by <- "row_names"
    names(join_by) <- first_col_name
    (
      result
      |> left_join(mapping, by = join_by)
      |> mutate( {{ first_col_name }} := rows_translated)
      |> select(- rows_translated)
    ) -> result
  }
  result
}

apply_all_filters <- function(result, filters) {

  apply_filter <- function(df, filter) {
    if (is.na(filter$value)) {
      dplyr::filter(df, !is.na(.data[[filter$column]]))
    } else {
      dplyr::filter(df, .data[[filter$column]] != filter$value)
    }
  }

  for (f in filters) result <- apply_filter(result, f)
  result
}

select_columns <- function(result, selected_columns) {
    dplyr::select(result, selected_columns)
}

rename_cols <- function(result, translated_columns) {
  names(result) <- translated_columns
  result
}

format_percentage_columns <- function(result) {
   dplyr::mutate(
    result,
    dplyr::across(dplyr::contains("%"),
      ~ scales::percent(as.numeric(.) / 100)))
}

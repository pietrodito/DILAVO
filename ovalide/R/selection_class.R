#' @export
selection <- function(lst = list()) {
  structure(
    lst,
    class = "selection"
  )
}

keep_last_occurrence_only <- function(lst) {
  lst |> rev() |> unique() |> rev()
}

#' @export
add_table <- function(selection, table_name, pos) {
  UseMethod("add_table")
}

#' @export
add_table.selection <- function(selection,
                                table_name,
                                pos = length(selection)) {
  new_selection <- append(selection, table_name, after = pos)
  result <- keep_last_occurrence_only(new_selection)
  selection(result)
}

#' @export
rm_table <- function(selection, table_name) {
  UseMethod("rm_table")
}
#' @export
rm_table.selection <- function(selection, table_name) {
  result <- setdiff(selection, table_name)
  selection(result)
}
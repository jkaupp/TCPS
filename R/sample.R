#' Retrieve file paths to TCPS sample data.
#'
#' tcps comes bundled with some example files in its `inst/extdata`
#' directory. This function make them easy to access by passing the sample name
#' as a quoted string.  It can be one of "staff_sample.xlsx", "student_sample.xlsx" or
#' "faculty_sample.xlsx"
#'
#' @param path Name of file. If `NULL`, the example files will be listed.
#' @param ... Additional parameters pass on to dir
#'
#' @export
tcps_sample <- function(path = NULL, ...) {
  if (is.null(path)) {
    dir(system.file("extdata", package = "tcps"), ...)
  } else {
    system.file("extdata", path, package = "tcps", mustWork = TRUE)
  }
}

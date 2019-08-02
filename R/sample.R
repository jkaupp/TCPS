#' Get path to tcps sample
#'
#' tcps comes bundled with some example files in its `inst/extdata`
#' directory. This function make them easy to access.
#'
#' @param path Name of file. If `NULL`, the example files will be listed.
#' @param ... Additional parameters pass on to dir
#'
#' @export
#' @examples
#' tcps_sample()
#' tcps_sample("student_sample.xlsx")
tcps_sample <- function(path = NULL, ...) {
  if (is.null(path)) {
    dir(system.file("extdata", package = "tcps"), ...)
  } else {
    system.file("extdata", path, package = "tcps", mustWork = TRUE)
  }
}

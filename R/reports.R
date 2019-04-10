#' Generate TCPS report
#'
#' @param path_to_data full file path to the directory containing the TCPS data sets
#' @param name_of_school string of the name of the institution
#' @param format string denoting the output format, one of "html", "word" or "pdf"
#'
#' @return Report in provided format in current working directory
#' @export
generate_report <- function(path_to_data, name_of_school, format = "html") {

  template <- file.path("inst/templates/tcps_report_template.Rmd")

  parameters <- list(path = path_to_data,
                     name = name_of_school)

  out_file <- sprintf("%s TCPS Lever Report.%s", name_of_school, ifelse(format == "word", "docx", format))

  format <- switch(format,
                   html = rmarkdown::html_document(),
                   word = rmarkdown::word_document(),
                   pdf = rmarkdown::pdf_document())

  # Use rmarkdown::render to produce a pdf report
  rmarkdown::render(input = template,
                    output_format = format,
                    output_file = out_file,
                    params = parameters,
                    clean = TRUE)

}

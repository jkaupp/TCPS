#' Read the TCPS from a qualtrics export file or files, and transform the data into a tidy format
#'
#' @param file full file path(s) to an excel file(s) exported from the survey system
#'
#' @return a single data frame containing only TCPS data, excludes all additional questions added to the survey.
#' @export
tcps_read_excel <- function(file) {

  if (length(file) == 1) {

    tcps_tidy_excel(file)

  } else {

    purrr::map_dfr(file, tcps_tidy_excel)

  }


}


#' Read the TCPS from a qualtrics export file and transform the data into a tidy format
#'
#' @param file full file path to an excel file exported from the survey system
#' @param name used for tcpsGUI to properly name the file.
#'
#' @return a tidy data frame containing only TCPS data, excludes all additional questions added to the survey.
tcps_tidy_excel <- function(file, name = NULL) {

  # Read in file with no column names
  data <- suppressMessages(readxl::read_excel(file, col_names = FALSE))

  data <- janitor::clean_names(data)

  # Determine where the data starts
  headers <- purrr::map(data, ~stringr::str_detect(.x, "\\b\\d\\b")) %>%
    purrr::reduce(`+`) %>%
    which(x = !is.na(.))

  # Capture header data
  header_dat <- dplyr::slice(data, headers)

  # transpose it into its own data frame
  metadata <- purrr::map_dfc(headers, ~t(header_dat[.x, ]))

  # Determine which column has question labels
  col <- purrr::map(metadata, ~sum(stringr::str_detect(.x, "L\\d-I\\d-[AI]"))) %>%
    purrr::keep(~.x > 0) %>%
    names()

  if (length(col) == 0){
    stop("There are no identifiable lever items in the data.  Please run vignette(tcps) and read 'Before you get started'")
  }

  # Remove the headers
  data <- dplyr::slice(data, -headers)

  # Put in long format
  long_data <- suppressMessages(purrr::set_names(data, metadata[[col]])) %>%
    janitor::clean_names() %>%
    dplyr::mutate(part_num = dplyr::row_number(.data$status)) %>%
    dplyr::select(.data$part_num, dplyr::matches("l\\d_i\\d_[ia]")) %>%
    tidyr::gather("question", "value", dplyr::matches("l\\d_i\\d_[ia]")) %>%
    dplyr::mutate(scale = dplyr::case_when(grepl("_a$", .data$question, ignore.case = TRUE) ~ "agreement",
                                           grepl("_i$", .data$question, ignore.case = TRUE) ~ "importance"),
                  item = readr::parse_number(stringr::str_extract(.data$question, "i([1-9])")),
                  lever = readr::parse_number(stringr::str_extract(.data$question, "l[1-6]")))

  # Summarize lever values
  levers <- long_data %>%
    dplyr::filter(!is.na(.data$scale)) %>%
    dplyr::group_by(.data$part_num, .data$lever, .data$scale) %>%
    dplyr::summarize(value = mean(as.numeric(.data$value), na.rm = TRUE)) %>%
    dplyr::ungroup() %>%
    dplyr::mutate(value = ifelse(is.nan(.data$value), NA_real_, .data$value),
                  question = sprintf("lever%s", .data$lever))


  survey_type <- if (is.null(name)) {

    survey_type <- stringr::str_extract(tolower(basename(file)), "faculty|staff|student")

  } else {

    survey_type <- stringr::str_extract(tolower(name), "faculty|staff|student")

  }

  # Bind both together and put into wide format
  long_data %>%
    dplyr::mutate(value = as.numeric(.data$value)) %>%
    dplyr::bind_rows(levers) %>%
    dplyr::mutate(question = dplyr::if_else(is.na(.data$item), .data$question, sprintf("lever%s_q%s", .data$lever, .data$item)),
                survey = survey_type) %>%
    dplyr::select(.data$part_num, .data$scale, .data$survey, .data$question, .data$value) %>%
    tidyr::spread(.data$question, .data$value, drop = TRUE)
}


if(getRversion() >= "2.15.1")  utils::globalVariables(c("."))

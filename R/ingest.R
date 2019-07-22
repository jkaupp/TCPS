#' Read the TCPS from a qualtrics export file and transform the data into a tidy format
#'
#' @param file full file path to an excel file exported from the survey system
#'
#' @return a tidy data frame containing only TCPS data, excludes all additional questions added to the survey.
#' @export
tcps_tidy_excel <- function(file) {

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
  col <- purrr::map(metadata, ~sum(stringr::str_detect(.x, "L\\d_I\\d_[AI]"))) %>%
    purrr::keep(~.x>0) %>%
    names()

  # Remove the headers
  data <- dplyr::slice(data, -headers)

  # Put in long format
  long_data <- suppressMessages(purrr::set_names(data, metadata[[col]])) %>%
    janitor::clean_names() %>%
    dplyr::mutate(part_num = dplyr::row_number(.data$status)) %>%
    dplyr::select(.data$part_num, dplyr::matches("l\\d_i\\d_[ia]")) %>%
    tidyr::gather(.data$question, .data$value, dplyr::matches("l\\d_i\\d_[ia]")) %>%
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

  # Bind both together and put into wide format
  long_data %>%
    dplyr::mutate(value = as.numeric(.data$value)) %>%
    dplyr::bind_rows(levers) %>%
    dplyr::mutate(question = dplyr::if_else(is.na(.data$item), .data$question, sprintf("lever%s_q%s", .data$lever, .data$item)),
                survey = stringr::str_extract(tolower(basename(file)), "faculty|staff|student")) %>%
    dplyr::select(.data$part_num, .data$scale, .data$survey, .data$question, .data$value) %>%
    tidyr::spread(.data$question, .data$value, drop = TRUE)
}



#' Read the TCPS data contained within an SPSS file generated the TCPS group and transform the data into a tidy format
#'
#' @param file full file path to the SPSS .sav file
#'
#' @return a tidy data frame of TCPS data
#' @export
tcps_tidy_spss <- function(file) {

  data <- haven::read_spss(file) %>%
    dplyr::mutate_if(haven::is.labelled, function(x) haven::as_factor(x, levels = "values")) %>%
    dplyr::mutate_if(is.factor, as.character) %>%
    dplyr::mutate(survey = stringr::str_extract(tolower(basename(file)), "Faculty|Staff|Student")) %>%
    dplyr::select(.data$survey, dplyr::contains("part", ignore.case = TRUE), dplyr::contains("lever", ignore.case = TRUE), dplyr::matches("Q\\d+_Q\\d+_\\d_\\d"), dplyr::matches("L\\d_[Ai]_Q\\d")) %>%
    dplyr::select(-dplyr::contains("PRIORITY")) %>%
    purrr::map_df(~replace(.x, is.nan(.x), NA)) %>%
    janitor::clean_names()

  data <- tidyr::gather(data, "item", "value", -.data$survey, -dplyr::contains("part", ignore.case = TRUE), convert = FALSE)

  srvy <- unique(data[["survey"]])


  data <- data %>%
    dplyr::mutate(scale = dplyr::case_when(grepl("a\\b", .data$item, ignore.case = TRUE) ~ "agreement",
                                           grepl("_a_", .data$item, ignore.case = TRUE) ~ "agreement",
                                           grepl("_i_", .data$item, ignore.case = TRUE) ~ "importance",
                                           grepl("i\\b", .data$item, ignore.case = TRUE) ~ "importance"),
                  item = ifelse(grepl("lever", .data$item, ignore.case = TRUE), stringr::str_extract(.data$item, "lever\\d"),  gsub("_[ai]_", "_", .data$item, ignore.case = TRUE)),
                  item = gsub("l(\\d)", "lever\\1", .data$item),
                  type = {{srvy}}) %>%
    dplyr::select(.data$survey, part_num = .data$participant, .data$scale, .data$item, .data$type, .data$value) %>%
    tidyr::spread("item", "value", drop = TRUE, convert = TRUE)

}

if(getRversion() >= "2.15.1")  utils::globalVariables(c("."))

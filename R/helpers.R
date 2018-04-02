#' Helper function to properly process and tidy TCPS data. Uses a tibble as input, and pmap to run the function
#'
#' @param data nested data column of the input tibble
#' @param survey survey type
#' @param lever lever choice
#' @param questions nested list of questions for each lever
#'
#' @return tidied tibble for each choice
scale_helper <- function(data, survey, lever, questions) {
  dplyr::select(data,
    dplyr::matches("survey"),
    .data$PartNum,
    dplyr::contains(lever),
    dplyr::one_of(purrr::map_chr(unlist(questions), ~ sprintf("%sa", .x))),
    dplyr::one_of(purrr::map_chr(unlist(questions), ~ sprintf("%si", .x)))) %>%
    dplyr::mutate_if(is.factor, as.numeric) %>%
    tidyr::gather("item", "value", names(.)[!grepl("PartNum|survey", names(.))]) %>%
    dplyr::mutate(scale = ifelse(grepl("agree|a\\b", .data$item), "agreement", "importance")) %>%
    dplyr::mutate(item = stringi::stri_replace_first_regex(.data$item, "\\bagree|\\bimp", ""),
      item = stringi::stri_replace_first_regex(.data$item, "a\\b|i\\b", "")
    ) %>%
    dplyr::mutate(type = ifelse(grepl("Q", .data$item), "question", "lever"))

}

#' Likert scale helper/contructor for lever_scale
#'
#' @param x input data frame to process
#'
#' @return a tidy data frame of likert data for a scale
scale_likert <- function(x) {

  plot_data <- x %>%
    dplyr::mutate_at(dplyr::vars(dplyr::matches("\\d+")), function(x)
      factor(
        x,
        c(1:5),
        c(
          "Not at All",
          "Very Little",
          "Somewhat",
          "Quite a Bit",
          "A Great Deal"
        )
      )) %>%
    dplyr::select(dplyr::matches("scale|\\d+"))

  item_names <- dplyr::filter(.questions, .data$question %in% names(plot_data)) %>%
    dplyr::pull(.data$prompt) %>%
    tools::toTitleCase()

  plot_data <- purrr::set_names(plot_data, c("scale", item_names))

  grouping <- tools::toTitleCase(plot_data[["scale"]])

  plot_data %>%
    dplyr::select(-.data$scale) %>%
    as.data.frame() %>%
    likert::likert(grouping = grouping)
}



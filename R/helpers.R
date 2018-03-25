scale_helper <- function(data, survey, lever, questions) {
  dplyr::select(data,
    dplyr::matches("survey"),
    .data$PartNum,
    dplyr::contains(lever),
    dplyr::one_of(purrr::map_chr(unlist(.data$questions), ~ sprintf("%sa", .x))),
    dplyr::one_of(purrr::map_chr(unlist(.data$questions), ~ sprintf("%si", .x)))
  ) %>%
    dplyr::mutate_if(is.factor, as.numeric) %>%
    tidyr::gather("item", "value", names(.data)[!grepl("PartNum|survey", names(.data))]) %>%
    dplyr::mutate(scale = ifelse(grepl("agree|a\\b", .data$item), "agreement", "importance")) %>%
    dplyr::mutate(item = stringi::stri_replace_first_regex(.data$item, "\\bagree|\\bimp", ""),
      item = stringi::stri_replace_first_regex(.data$item, "a\\b|i\\b", "")
    ) %>%
    dplyr::mutate(type = ifelse(grepl("Q", .data$item), "question", "lever"))

}

scale_likert <- function(x) {

  plot_data <- x %>%
    dplyr::mutate(item = ~ readr::parse_number(.data$item)) %>%
    dplyr::arrange(.data$item) %>%
    tidyr::spread("item", "value") %>%
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
    dplyr::select(dplyr::matches("scale|\\d+")) %>%
    purrr::set_names(c("scale", sprintf("Q%s", names(.data)[-1])))


  item_names <- dplyr::filter(.questions, .data$question %in% names(plot_data)) %>%
    dplyr::select(.data$prompt) %>%
    purrr::flatten_chr() %>%
    tools::toTitleCase()

  plot_data <- purrr::set_names(plot_data, c("scale", item_names))

  grouping <- tools::toTitleCase(plot_data[["scale"]])

  plot_data %>%
    dplyr::select(-.data$scale) %>%
    dplyr::as_data_frame() %>%
    likert::likert(grouping = grouping)
}



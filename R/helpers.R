scale_helper <- function(data, survey, lever, questions){

  dplyr::select_(data, ~matches("survey"), ~PartNum, ~dplyr::contains(lever), ~dplyr::one_of(map_chr(unlist(questions), ~sprintf("%sa",.x))), ~dplyr::one_of(map_chr(unlist(questions), ~sprintf("%si",.x)))) %>%
    dplyr::mutate_if(is.factor, as.numeric) %>%
    tidyr::gather_("item", "value", names(.)[!grepl("PartNum|survey", names(.))]) %>%
    dplyr::mutate_(scale = ~ifelse(grepl("agree|a\\b", item), "agreement", "importance")) %>%
    dplyr::mutate_(item = ~stringi::stri_replace_first_regex(item, "\\bagree|\\bimp", ""),
                   item = ~stringi::stri_replace_first_regex(item, "a\\b|i\\b", "")) %>%
    dplyr::mutate_(type = ~ifelse(grepl("Q", item), "question", "lever"))

}

scale_likert <- function(x){

  plot_data <- x %>%
    dplyr::mutate_(item = ~readr::parse_number(item)) %>%
    dplyr::arrange_("item") %>%
    tidyr::spread_("item", "value") %>%
    dplyr::mutate_at(dplyr::vars(dplyr::matches("\\d+")), function(x) factor(x, c(1:5), c("Not at All", "Very Little", "Somewhat", "Quite a Bit", "A Great Deal"))) %>%
    dplyr::select_(~dplyr::matches("scale|\\d+")) %>%
    stats::setNames(c("scale", sprintf("Q%s", names(.)[-1])))

  # %>%
  #   dplyr::mutate_at(.cols = dplyr::vars(contains("Q")),
  #                    function(x) forcats::fct_recode(x, "Low" = "Not at All",
  #                                                    "Low" = "Very Little",
  #                                                    "Neutral" = "Somewhat",
  #                                                    "High" = "Quite a Bit",
  #                                                    "High" = "A Great Deal"))

  item_names <- dplyr::filter_(.questions, ~question %in% names(plot_data)) %>%
     dplyr::select_(~prompt) %>%
     purrr::flatten_chr() %>%
     tools::toTitleCase()

  plot_data <- stats::setNames(plot_data, c("scale", item_names))

  grouping <- tools::toTitleCase(plot_data[["scale"]])

  plot_data %>%
    dplyr::select_(~-scale) %>%
    as.data.frame() %>%
    likert::likert(grouping = grouping)
}

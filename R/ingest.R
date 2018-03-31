read_tcps <- function(x){

 data <- haven::read_sav(x) %>%
    dplyr::mutate_if(haven::is.labelled, function(x) haven::as_factor(x, levels = "label")) %>%
    dplyr::mutate(survey = stringi::stri_extract_first_regex(basename(x), "Faculty|Staff|Students")) %>%
    dplyr::select(.data$survey, .data$PartNum, dplyr::contains("agree"), dplyr::contains("imp"), dplyr::matches("Q\\d+[ai]\\b")) %>%
    purrr::map_df(~replace(.x, is.nan(.x), NA))

  srvy <- rlang::quo(unique(data[["survey"]]))

  selection <- dplyr::filter(.faculty_levers, .data$survey == UQ(srvy))

  selection$data <- list(data)

  purrr::pmap_df(selection, scale_helper)

}

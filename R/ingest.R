read_tcps <- function(x){

 data <- haven::read_sav(x) %>%
    dplyr::mutate_if(haven::is.labelled, function(x) haven::as_factor(x, levels = "label")) %>%
    dplyr::mutate_(survey = ~stringi::stri_extract_first_regex(basename(x), "Faculty|Staff|Students")) %>%
    dplyr::select_(~survey, ~PartNum, ~dplyr::contains("agree"), ~dplyr::contains("imp"), ~dplyr::matches("Q\\d+[ai]\\b")) %>%
    purrr::map_df(~replace(.x, is.nan(.x), NA))

  srvy <- unique(data[["survey"]])

  selection <- dplyr::filter_(.faculty_levers, ~survey == srvy)

  selection$data <- list(data)

  pmap_df(selection, scale_helper)

}

read_tcps <- function(x){

 haven::read_sav(x) %>%
    dplyr::mutate_if(haven::is.labelled, function(x) haven::as_factor(x, levels = "label")) %>%
    dplyr::mutate_(survey = ~stringi::stri_extract_first_regex(basename(x), "Faculty|Stff|Students")) %>%
    dplyr::select_(~survey, ~PartNum, ~dplyr::contains("agree"), ~dplyr::contains("imp"), ~dplyr::matches("Q\\d+[ai]\\b")) %>%
    purrr::map_df(~replace(.x, is.nan(.x), NA))

}

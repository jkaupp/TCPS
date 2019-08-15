#' Calculate basic summary statistics for a tidied data frame of TCPS data
#'
#' @param data
#'
#' @return a data frame of summary statistics for each scale, survey group and question
#' @export
#'
#' @examples
#' tcps_summary_stats(tcps_sample("staff_sample.xlsx"))
tcps_summary_stats <- function(data) {

  data %>%
    dplyr::select(-.data$part_num) %>%
    tidyr::gather("lever", "value", dplyr::contains("lever")) %>%
    dplyr::group_by(.data$scale, .data$survey, .data$lever) %>%
    dplyr::summarise_all(.funs = list(mean = mean, median = median, sd = sd, n = dplyr::n_distinct), na.rm = TRUE) %>%
    dplyr::mutate(sem = .data$sd/sqrt(.data$n)) %>%
    tidyr::gather("measure", "value", c("mean","median","sd", "n", "sem")) %>%
    tidyr::spread("lever", "value")


}

.levers <-
  stats::setNames(
    c(
      "Institutional Initiatives",
      "Assessment of Teaching",
      "Implementing Effective Teaching",
      "Infrastructure Supporting Teaching",
      "Broad Engagement Around Teaching",
      "Recognizing Effective Teaching"
    ),
    c(
      "instinit",
      "assessteach",
      "impteach",
      "infrastruct",
      "brengage",
      "teachrec"
    )
  )

.faculty_levers <-
  tibble::tibble(
    survey = rep(c("Faculty", "Staff", "Students"), each = 6),
    lever = rep(
      c(
        "instinit",
        "assessteach",
        "impteach",
        "infrastruct",
        "brengage",
        "teachrec"
      ),
      3
    ),
    questions = list(
      sprintf("Q%s", 6:11),
      sprintf("Q%s", 12:17),
      sprintf("Q%s", 18:24),
      sprintf("Q%s", 25:29),
      sprintf("Q%s", 30:36),
      sprintf("Q%s", 37:42),
      sprintf("Q%s", 7:12),
      sprintf("Q%s", 13:16),
      sprintf("Q%s", 17:22),
      sprintf("Q%s", 23:28),
      sprintf("Q%s", 29:34),
      sprintf("Q%s", 35:39),
      sprintf("Q%s", 8:12),
      sprintf("Q%s", 13:17),
      sprintf("Q%s", 18:23),
      sprintf("Q%s", 24:28),
      sprintf("Q%s", 29:34),
      sprintf("Q%s", 35:38)
    )
  )

scale_helper <- function(data, survey, lever, questions){

  dplyr::select_(data, ~matches("survey"), ~PartNum, ~dplyr::contains(lever), ~dplyr::one_of(map_chr(unlist(questions), ~sprintf("%sa",.x))), ~dplyr::one_of(map_chr(unlist(questions), ~sprintf("%si",.x)))) %>%
    dplyr::mutate_if(is.factor, as.numeric) %>%
    tidyr::gather_("item", "value", names(.)[!grepl("PartNum|survey", names(.))]) %>%
    dplyr::mutate_(scale = ~ifelse(grepl("agree|a\\b", item), "agreement", "importance")) %>%
    dplyr::mutate_(item = ~stringi::stri_replace_first_regex(item, "\\bagree|\\bimp", ""),
                   item = ~stringi::stri_replace_first_regex(item, "a\\b|i\\b", "")) %>%
    dplyr::mutate_(type = ~ifelse(grepl("Q", item), "question", "lever"))

}

lever_paracords <- function(x) {

plot_data <- x %>%
  dplyr::select_(~survey, ~PartNum, ~dplyr::contains("agree"), ~dplyr::contains("imp")) %>%
    tidyr::gather_("lever", "value", colnames(.)[!grepl("PartNum|survey", colnames(.))]) %>%
    dplyr::mutate_(lever_type = ~stringi::stri_extract_first_regex(lever, "\\bagree|\\bimp"),
                   lever = ~gsub("\\bagree|\\bimp", "", lever))

ggplot2::ggplot(plot_data, ggplot2::aes(x = lever, y = value)) +
  ggplot2::geom_line(ggplot2::aes(color = lever_type, group = PartNum), alpha = 0.2, size = 0.15) +
  ggplot2::geom_line(ggplot2::aes(color = lever_type, group = 1), stat = "summary", fun.y = "mean", size = 1) +
  ggplot2::scale_size_area(max_size = 10) +
  ggplot2::scale_y_continuous(limits = c(1,5), labels = c("Not at All", "Very Little", "Somewhat", "Quite a Bit", "A Great Deal")) +
  ggplot2::facet_wrap(~lever_type) +
  ggplot2::scale_color_manual(values = c("#E74C3C","#3498DB")) +
  ggplot2::labs(x = NULL, y = NULL, title = "") +
  ggplot2::theme_light()
}

lever_bubble <- function(x) {

  plot_data <- x %>%
    dplyr::select_(~survey, ~PartNum, ~dplyr::contains("agree"), ~dplyr::contains("imp")) %>%
    tidyr::gather_("lever", "value", colnames(.)[!grepl("PartNum|survey", colnames(.))]) %>%
    dplyr::mutate_(lever_type = ~stringi::stri_extract_first_regex(lever, "\\bagree|\\bimp"),
                   lever = ~gsub("\\bagree|\\bimp", "", lever)) %>%
    dplyr::group_by_(~lever_type, ~lever) %>%
    dplyr::filter(!is.na(value)) %>%
    dplyr::summarize(mean = mean(value, na.rm = TRUE),
                     percent = 100*n()/max(x[["PartNum"]]))

  ggplot2::ggplot(plot_data, ggplot2::aes(x = lever, y = mean)) +
    ggalt::geom_xspline(ggplot2::aes(color = lever_type, group = lever_type)) +
    ggplot2::geom_point(ggplot2::aes(fill = lever_type, group = lever_type, size = percent), color = "white", shape = 21) +
    ggplot2::scale_size_area(max_size = 10) +
    ggplot2::scale_y_continuous(limits = c(1,5), labels = c("Not at All", "Very Little", "Somewhat", "Quite a Bit", "A Great Deal")) +
    ggplot2::scale_fill_manual(values = c("#E74C3C","#3498DB")) +
    ggplot2::scale_color_manual(values = c("#E74C3C","#3498DB")) +
    ggplot2::labs(x = NULL, y = NULL, title = "") +
    ggplot2::theme_tcps()
}

lever_scatter <- function(x) {

  plot_data <- x %>%
    dplyr::select_(~survey, ~PartNum, ~dplyr::contains("agree"), ~dplyr::contains("imp")) %>%
    tidyr::gather_("lever", "value", colnames(.)[!grepl("PartNum|survey", colnames(.))]) %>%
    dplyr::mutate_(lever_type = ~stringi::stri_extract_first_regex(lever, "\\bagree|\\bimp"),
                   lever = ~gsub("\\bagree|\\bimp", "", lever)) %>%
    tidyr::spread_("lever_type", "value") %>%
    dplyr::filter(complete.cases(.)) %>%
    dplyr::mutate_(color = ~dplyr::if_else(imp/agree > 1, "above", "below"))

  ggplot2::ggplot(plot_data, ggplot2::aes(x = agree, y = imp)) +
    ggplot2::geom_abline(slope = 1, color = "grey20", alpha = 0.2) +
    ggplot2::geom_point(ggplot2::aes(color = color), alpha = 0.5) +
    ggplot2::scale_y_continuous(limits = c(1,5), labels = c("Not at All", "Very Little", "Somewhat", "Quite a Bit", "A Great Deal")) +
    ggplot2::scale_x_continuous(limits = c(1,5), labels = c("Not at All", "Very Little", "Somewhat", "Quite a Bit", "A Great Deal")) +
    ggplot2::expand_limits(x = c(0,7), y = c(0,7)) +
    ggplot2::facet_wrap(~lever) +
    ggplot2::scale_color_manual(values = rev(c("#E74C3C","#3498DB"))) +
    ggplot2::labs(x = "Importance", y = "Agreement", title = "") +
    theme_tcps()
}

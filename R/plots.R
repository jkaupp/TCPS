lever_paracords <- function(x) {

plot_data <- x %>%
  dplyr::filter_(~type == "lever") %>%
  dplyr::mutate_(item = ~.levers[item])

ggplot2::ggplot(plot_data, ggplot2::aes(x = item, y = value)) +
  ggplot2::geom_line(ggplot2::aes(color = scale, group = PartNum), alpha = 0.2, size = 0.15) +
  ggplot2::geom_line(ggplot2::aes(color = scale, group = 1), stat = "summary", fun.y = "mean", size = 1) +
  ggplot2::scale_size_area(max_size = 10) +
  ggplot2::scale_y_continuous(limits = c(1,5), labels = c("Not at All", "Very Little", "Somewhat", "Quite a Bit", "A Great Deal")) +
  ggplot2::scale_x_discrete(labels = function(x) stringr::str_wrap(x, 5)) +
  ggplot2::facet_wrap(~scale, labeller = ggplot2::as_labeller(function(x) tools::toTitleCase(x))) +
  ggplot2::scale_color_manual(values = c("#E74C3C","#3498DB")) +
  ggplot2::labs(x = NULL, y = NULL, title = "") +
  theme_tcps() +
  ggplot2::theme(legend.position = "none")
}

lever_bubble <- function(x) {

  plot_data <- x %>%
    dplyr::filter_(~type == "lever") %>%
    dplyr::group_by_(~scale, ~item) %>%
    dplyr::filter(!is.na(value)) %>%
    dplyr::summarize(mean = mean(value, na.rm = TRUE),
                     percent = 100*n()/max(x[["PartNum"]])) %>%
    dplyr::mutate_(item = ~.levers[item])

  ggplot2::ggplot(plot_data, ggplot2::aes(x = item, y = mean)) +
    ggalt::geom_xspline(ggplot2::aes(color = scale, group = scale)) +
    ggplot2::geom_point(ggplot2::aes(fill = scale, group = scale, size = percent), color = "white", shape = 21, show.legend = FALSE) +
    ggplot2::scale_size_area(max_size = 10) +
    ggplot2::scale_y_continuous(limits = c(1,5), labels = c("Not at All", "Very Little", "Somewhat", "Quite a Bit", "A Great Deal")) +
    ggplot2::scale_x_discrete(labels = function(x) stringr::str_wrap(x, 5)) +
    ggplot2::scale_fill_manual(values = c("#E74C3C","#3498DB")) +
    ggplot2::scale_color_manual(values = c("#E74C3C","#3498DB")) +
    ggplot2::labs(x = NULL, y = NULL, title = "") +
    theme_tcps()
}

lever_scatter <- function(x) {

  plot_data <- x %>%
    dplyr::filter_(~type == "lever") %>%
    dplyr::group_by_(~PartNum, ~item, ~scale) %>%
    dplyr::summarize(value = unique(value)) %>%
    tidyr::spread_("scale", "value") %>%
    dplyr::ungroup() %>%
    dplyr::filter(complete.cases(.)) %>%
    dplyr::mutate_(color = ~dplyr::if_else(importance/agreement > 1, "above", "below")) %>%
    dplyr::mutate_(lever = ~.levers[item])

  ggplot2::ggplot(plot_data, ggplot2::aes(x = agreement, y = importance)) +
    ggplot2::geom_abline(slope = 1, color = "grey20", alpha = 0.2) +
    ggplot2::geom_point(ggplot2::aes(color = color), alpha = 0.5) +
    ggplot2::scale_y_continuous(limits = c(1,5), labels = c("Not at All", "Very Little", "Somewhat", "Quite a Bit", "A Great Deal")) +
    ggplot2::scale_x_continuous(limits = c(1,5), labels = c("Not at All", "Very Little", "Somewhat", "Quite a Bit", "A Great Deal")) +
    ggplot2::expand_limits(x = c(0,7), y = c(0,7)) +
    ggplot2::facet_wrap(~lever) +
    ggplot2::scale_color_manual("", values = rev(c("#E74C3C","#3498DB")), labels = c("Importance > Agreement", "Agreement > Importance")) +
    ggplot2::labs(y = "Importance", x = "Agreement", title = "") +
    theme_tcps() +
    ggplot2::theme(legend.position = "bottom")
}


likert_scale <- function(x, choice) {

  type <- unique(x[["survey"]])

  questions <- dplyr::filter_(.faculty_levers, ~lever == choice, ~survey == type) %>%
    tidyr::unnest_("questions") %>%
    dplyr::select_(~questions) %>%
    purrr::flatten_chr()

  scales <- dplyr::filter_(x, ~item %in% questions)

  scale_bar <- scale_likert(scales)

  ggplot2::update_geom_defaults("bar", list(colour = "grey30", size = 0.15))
  ggplot2::update_geom_defaults("text", list(family = "Lato"))

  plot(scale_bar, colors = viridisLite::viridis(5), text.size = 4, plot.percent.neutral = FALSE, panel.arrange = "v", legend.position = "none") +
    theme_tcps(grid = FALSE) +
    ggplot2::labs(title = type,
                  y = "Percent of response") +
    ggplot2::theme(strip.text.x = ggplot2::element_text(hjust = 0.5, size = 14),
                   axis.text.x = ggplot2::element_blank(),
                   axis.text.y = ggplot2::element_text(size = 14),
                   plot.title = ggplot2::element_text(size = 18),
                   legend.position = "none")

}

lever_scale <- function(df, choice) {

  plots <- df %>%
    split(.[["survey"]]) %>%
    purrr::map(~likert_scale(.x, choice))

    gridExtra::grid.arrange(grobs = plots, ncol = 3)

}

lever_joyplot <- function(x, aggregate) {

  plot_data <- x %>%
    dplyr::filter_(~type == "lever") %>%
    dplyr::mutate_(item = ~.levers[item],
                   scale = ~tools::toTitleCase(scale))

  plot <- ggplot2::ggplot(plot_data, ggplot2::aes(x = value, y = item, fill = scale)) +
    ggjoy::geom_joy(alpha = 0.8, color = "grey30", rel_min_height = 0.01, size = 0.15) +
    ggplot2::scale_x_continuous(expand = c(0, 0.2), limits = c(1,6), breaks = 1:5, labels = stringr::str_wrap(c("Not at All", "Very Little", "Somewhat", "Quite a Bit", "A Great Deal"), 7)) +
    ggplot2::scale_y_discrete(expand = c(0, 0), labels = function(x) stringr::str_wrap(x, 15)) +
    ggplot2::scale_fill_manual("", values = c("#F6D600","#11CD86")) +
    ggplot2::scale_color_manual("", values = c("#F6D600","#11CD86")) +
    ggplot2::labs(x = NULL, y = NULL, title = NULL) +
    theme_tcps(grid = "XY") +
    ggplot2::theme(legend.position = "none")

  #c("#E74C3C","#3498DB")

  if (!aggregate) {

    plot +  ggplot2::facet_wrap(~survey)

  } else {

    plot
  }

}


lever_scale2 <- function(x, choice) {

  questions <- dplyr::filter_(.faculty_levers, ~lever == choice) %>%
    tidyr::unnest_("questions") %>%
    dplyr::select_(~questions) %>%
    purrr::flatten_chr()

  scales <- dplyr::filter_(x, ~item %in% questions) %>%
    dplyr::left_join(.questions, by = c("item" = "question")) %>%
    dplyr::mutate_(prompt = ~tools::toTitleCase(prompt))

  ggplot2::ggplot(scales, ggplot2::aes(x = value, y = prompt, fill = scale)) +
    ggjoy::geom_joy(alpha = 0.8, color = "grey30", rel_min_height = 0.01, size = 0.4, scale = 2) +
    ggplot2::scale_color_manual(values = c("#E74C3C","#3498DB"), labels = c("Agreement","Importance")) +
    ggplot2::scale_fill_manual(values = c("#E74C3C","#3498DB"), labels = c("Agreement","Importance")) +
    ggplot2::scale_x_continuous(expand = c(0, 0), limits = c(0,6), breaks = c(1:5), labels = stringr::str_wrap(c("Not at All", "Very Little", "Somewhat", "Quite a Bit", "A Great Deal"), 7)) +
    ggplot2::scale_y_discrete(expand = c(0, 0), labels = function(x) stringr::str_wrap(x, 35)) +
    ggplot2::labs(x = NULL, y = NULL, title = NULL, subtitle = NULL) + #.levers[[choice]]
    theme_tcps(grid = "XY") +
    ggplot2::facet_wrap(~survey) +
    ggplot2::theme(legend.position = "none")

}


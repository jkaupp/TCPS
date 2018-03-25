likert_scale <- function(x, choice) {

  type <- quo(unique(x[["survey"]]))

  questions <- dplyr::filter(.faculty_levers, .data$lever == choice, .data$survey == UQ(type)) %>%
    tidyr::unnest("questions") %>%
    dplyr::select(.data$questions) %>%
    purrr::flatten_chr()

  scales <- dplyr::filter(x, .data$item %in% questions)

  counts <- dplyr::n_distinct(scales[["PartNum"]])

  scale_bar <- scale_likert(scales)

  title <- sprintf("%s (%s)", type, counts)

  ggplot2::update_geom_defaults("bar", list(colour = "grey30", size = 0.15))
  ggplot2::update_geom_defaults("text", list(family = "Lato"))

  graphics::plot(scale_bar, colors = viridisLite::viridis(5), text.size = 4, plot.percent.neutral = FALSE, panel.arrange = "v", legend.position = "none") +
    theme_tcps(grid = FALSE) +
    ggplot2::labs(title = title,
                  y = NULL,
                  x = NULL) +
    ggplot2::theme(strip.text.x = ggplot2::element_text(hjust = 0.5, size = 14),
                   #axis.text.x = ggplot2::element_blank(),
                   axis.text.y = ggplot2::element_text(size = 14),
                   plot.title = ggplot2::element_text(size = 18),
                   legend.position = "none")

}

lever_scale <- function(df, choice) {

  cols <- length(unique(df[["survey"]]))

  if (cols > 1) {

    plots <- split(df, df[["survey"]]) %>%
      purrr::map(~likert_scale(.x, choice))

    gridExtra::grid.arrange(grobs = plots, ncol = cols)
  } else {
    likert_scale(df, choice)
  }

}

lever_ridgeline <- function(x, aggregate) {

  plot_data <- x %>%
    dplyr::filter(.data$type == "lever") %>%
    dplyr::mutate(item = .levers[.data$item],
                   scale = tools::toTitleCase(.data$scale))

  order <- plot_data %>%
    dplyr::group_by(.data$item, .data$scale) %>%
    dplyr::summarize(mean = mean(.data$value, na.rm = TRUE)) %>%
    dplyr::transmute(diff = ~diff(mean)) %>%
    dplyr::ungroup() %>%
    dplyr::distinct(.data$item, .data$diff) %>%
    dplyr::arrange(.data$diff) %>%
    dplyr::select(.data$item) %>%
    purrr::flatten_chr()

  plot <- ggplot2::ggplot(plot_data, ggplot2::aes_(x = ~value, y = ~item, fill = ~scale)) +
    ggridges::geom_density_ridges(alpha = 0.8, color = "grey30", rel_min_height = 0.01, size = 0.15) +
    ggplot2::scale_x_continuous(expand = c(0, 0.2), limits = c(1,6), breaks = c(1,3,5), labels = stringr::str_wrap(c("Less Emphasis", "Neutral", "More Emphasis"), 7)) +
    ggplot2::scale_y_discrete(expand = c(0, 0), limits = order,  labels = function(x) stringr::str_wrap(x, 15)) +
    ggplot2::scale_fill_manual("", values = c("#F6D600","#11CD86")) +
    ggplot2::scale_color_manual("", values = c("#F6D600","#11CD86")) +
    ggplot2::labs(x = NULL, y = NULL, title = NULL) +
    theme_tcps(grid = "XY") +
    ggplot2::theme(legend.position = "none")

  if (!aggregate) {

    counts <- plot_data %>%
      #dplyr::filter_(~!is.na(value)) %>%
      dplyr::group_by(.data$survey) %>%
      dplyr::summarize(n = dplyr::n_distinct(.data$PartNum))

    counts <- purrr::set_names(counts$n, counts$survey)

    appender <- function(string) sprintf("%s (%s)", string, counts[string])

    plot +  ggplot2::facet_wrap(~survey, labeller = ggplot2::as_labeller(appender))

  } else {

    counts <- plot_data %>%
      dplyr::group_by(.data$survey) %>%
      dplyr::summarize(n = dplyr::n_distinct(.data$PartNum)) %>%
      dplyr::ungroup() %>%
      dplyr::summarize(n = sum(.data$n)) %>%
      purrr::flatten_chr()

    plot + ggplot2::labs(subtitle = sprintf("Queen's (%s)",counts))
  }

}




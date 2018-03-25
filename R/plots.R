likert_scale <- function(x, choice) {

  type <- unique(x[["survey"]])

  questions <- dplyr::filter_(.faculty_levers, ~lever == choice, ~survey == type) %>%
    tidyr::unnest_("questions") %>%
    dplyr::select_(~questions) %>%
    purrr::flatten_chr()

  scales <- dplyr::filter_(x, ~item %in% questions)

  counts <- dplyr::n_distinct(scales[["PartNum"]])

  scale_bar <- scale_likert(scales)

  title <- sprintf("%s (%s)", type, counts)

  ggplot2::update_geom_defaults("bar", list(colour = "grey30", size = 0.15))
  ggplot2::update_geom_defaults("text", list(family = "Lato"))

  plot(scale_bar, colors = viridisLite::viridis(5), text.size = 4, plot.percent.neutral = FALSE, panel.arrange = "v", legend.position = "none") +
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

    plots <- df %>%
      split(.[["survey"]]) %>%
      purrr::map(~likert_scale(.x, choice))

    gridExtra::grid.arrange(grobs = plots, ncol = cols)
  } else {
    likert_scale(df, choice)
  }

}

lever_ridgeline <- function(x, aggregate) {

  plot_data <- x %>%
    dplyr::filter_(~type == "lever") %>%
    dplyr::mutate_(item = ~.levers[item],
                   scale = ~tools::toTitleCase(scale))

  order <- plot_data %>%
    dplyr::group_by_(~item, ~scale) %>%
    dplyr::summarize_(mean = ~mean(value, na.rm = TRUE)) %>%
    dplyr::transmute_(diff = ~diff(mean)) %>%
    dplyr::ungroup() %>%
    dplyr::distinct_(~item, ~diff) %>%
    dplyr::arrange_(~diff) %>%
    dplyr::select_(~item) %>%
    purrr::flatten_chr()

  plot <- ggplot2::ggplot(plot_data, ggplot2::aes(x = value, y = item, fill = scale)) +
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
      dplyr::group_by_(~survey) %>%
      dplyr::summarize_(n = ~dplyr::n_distinct(PartNum))

    counts <- purrr::set_names(counts$n, counts$survey)

    appender <- function(string) sprintf("%s (%s)", string, counts[string])

    plot +  ggplot2::facet_wrap(~survey, labeller = ggplot2::as_labeller(appender))

  } else {

    counts <- plot_data %>%
      dplyr::group_by_(~survey) %>%
      dplyr::summarize_(n = ~dplyr::n_distinct(PartNum)) %>%
      dplyr::ungroup() %>%
      dplyr::summarize(n = sum(n)) %>%
      purrr::flatten_chr()

    plot + ggplot2::labs(subtitle = sprintf("Queen's (%s)",counts))
  }

}



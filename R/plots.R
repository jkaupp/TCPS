#' Create a likert scale plot for agreement and importance for a TCPS lever
#'
#' @param x input tidy TCPS data
#' @param choice lever choice
#'
#' @return nify plot!
likert_scale <- function(x, choice) {

  type <- quo(unique(x[["survey"]]))

  questions <- dplyr::filter(.tcps, .data$lever == choice, .data$survey == UQ(type)) %>%
    tidyr::unite("question", lever, question, sep = "_") %>%
    dplyr::pull(.data$question)

  scales <- dplyr::select(x, .data$survey, .data$part_num, .data$scale, questions)

  counts <- dplyr::n_distinct(scales[["part_num"]])

  scale_bar <- scale_likert(scales)

  title <- sprintf("%s (%s)", unique(x[["survey"]]), counts)

  ggplot2::update_geom_defaults("bar", list(colour = "grey30", size = 0.15))
  ggplot2::update_geom_defaults("text", list(family = "Lato"))

  graphics::plot(scale_bar, colors = viridisLite::viridis(5), text.size = 4, plot.percent.neutral = FALSE, panel.arrange = "v", legend.position = "none") +
    theme_tcps(grid = FALSE) +
    ggplot2::labs(subtitle = title,
                  y = NULL,
                  x = NULL) +
    ggplot2::theme(strip.text.x = ggplot2::element_text(hjust = 0.5, size = 14),
                   #axis.text.x = ggplot2::element_blank(),
                   plot.subtitle = element_text(hjust = 0),
                   axis.text.y = ggplot2::element_text(size = 14),
                   plot.title = ggplot2::element_text(size = 18),
                   legend.position = "bottom")

}


#' Produce the lever scale item visualization
#'
#' @param x the input tidy tcps data frame
#' @param choice the short name for the lever scale
#'
#' @return nify plot
#' @export
lever_scale <- function(x, choice) {

  cols <- length(unique(x[["survey"]]))

  lever <- gsub("lever(\\d)", "Lever \\1", choice)

  if (cols > 1) {

    plots <- split(x, x[["survey"]]) %>%
      purrr::map(~likert_scale(.x, choice))

    legend <- extract_legend(plots[[1]])

    plots <- map(plots, remove_legend)

      gridExtra::grid.arrange(gridExtra::arrangeGrob(grobs = plots, ncol = cols, top = grid::textGrob(sprintf("TCPS %s plots for University of Winsdor", lever), x = 0.19, gp = grid::gpar(fontsize = 20, fontfamily = "Oswald-Light"))), legend, nrow = 2,heights = c(10, 1))
  } else {
    likert_scale(x, choice)
  }

}

#' Produce ridgeline plots for a TCPS lever.
#'
#' @param x input tidy TCPS data frame
#' @param aggregate TRUE/FALSE.  If TRUE, aggregate responses across all populations (surveys) in the data frame
#' @param lever short name of the lever of interest
#' @param pal a simple two color palette for agreement/importance in the plot.
#'
#' @return a nifty plot!
#' @export
lever_ridgeline <- function(x, lever = NULL, pal = pal_one, aggregate = FALSE) {

  plot_data <- x %>%
    dplyr::select(-dplyr::contains("q")) %>%
    tidyr::gather("item", "value", dplyr::contains("lever"), convert = FALSE)

  if (!is.null(lever)) {

    lvr <- rlang::quo_name(lever)

    plot_data <- dplyr::filter(plot_data, .data$item == lvr) %>%
      dplyr::mutate(item = .levers[.data$item],
                    scale = tools::toTitleCase(.data$scale))

  } else {
    plot_data <- plot_data %>%
      dplyr::mutate(item = .levers[.data$item],
                    scale = tools::toTitleCase(.data$scale))

  }

  order <- plot_data %>%
    dplyr::group_by(.data$item, .data$scale) %>%
    dplyr::summarize(mean = mean(.data$value, na.rm = TRUE)) %>%
    dplyr::mutate(diff = diff(.data$mean)) %>%
    dplyr::ungroup() %>%
    dplyr::distinct(.data$item, .data$diff) %>%
    dplyr::arrange(.data$diff) %>%
    dplyr::pull(.data$item)

  plot <- ggplot2::ggplot(plot_data, ggplot2::aes_(x = ~value, y = ~item, fill = ~scale)) +
    ggridges::geom_density_ridges(alpha = 0.8, color = "grey30", rel_min_height = 0.01, size = 0.15, na.rm = TRUE) +
    ggplot2::scale_x_continuous(expand = c(0, 0.2), limits = c(0,6), breaks = c(1,3,5), labels = stringr::str_wrap(c("Less Emphasis", "Neutral", "More Emphasis"), 7)) +
    ggplot2::scale_y_discrete(expand = c(0, 0), limits = order,  labels = function(x) stringr::str_wrap(x, 15)) +
    ggplot2::scale_fill_manual("", values = pal) +
    ggplot2::scale_color_manual("", values = pal) +
    ggplot2::labs(x = NULL, y = NULL, title = "TCPS Lever ridgeline plots for University of Windsor", subtitle = "Yellow fill represents the agreement scale, blue fill represents the importance scale.") +
    theme_tcps(grid = "XY") +
    ggplot2::theme(legend.position = "none")

  if (!aggregate) {

    counts <- plot_data %>%
      dplyr::group_by(.data$survey) %>%
      dplyr::summarize(n = dplyr::n_distinct(.data$part_num))

    counts <- purrr::set_names(counts$n, counts$survey)

    appender <- function(string) sprintf("%s (%s)", string, counts[string])

    if (!is.null(lever) | !aggregate){
      plot + ggplot2::facet_wrap(~survey, labeller = ggplot2::as_labeller(appender))
    } else {
      plot
    }

  } else {

    counts <- plot_data %>%
      dplyr::group_by(.data$survey) %>%
      dplyr::summarize(n = dplyr::n_distinct(.data$part_num)) %>%
      dplyr::ungroup() %>%
      dplyr::summarize(n = sum(.data$n)) %>%
      purrr::flatten_chr()

    plot + ggplot2::labs(subtitle = sprintf("%s responses",counts))
  }

}




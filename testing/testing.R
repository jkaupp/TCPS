library(magrittr)
library(purrr)
library(dplyr)

files <- list.files(file.path("inst", "data"), full.names = TRUE, pattern = "sav")

data <- files %>%
  map_df(~read_tcps(.x))

filter(data, survey == "Staff", item == "instinit") %>% lever_joyplot()

p + scale_fill_manual("", values = c(grey.colors(2))) +
  scale_y_discrete(expand = c(0,0)) +
  theme(strip.text = element_blank(),
        axis.text.y = element_blank(),
        legend.position = "none",
        panel.grid.major = element_blank())


lever_joyplot(data, aggregate = TRUE) +
  theme(legend.position = "none",
        axis.text.y = element_text(vjust = 0),
        panel.grid.major.x = element_line(linetype = "dashed"),
        panel.grid.major.y = element_blank())


ggplot2::ggsave(filename = "instinit.png", width = 6, height = 4, units = "in")


gen_scales <- function(data, scale) {

  png(sprintf("%s.png", scale), width = 22, height = 10, units = "in", res = 200)
  lever_scale(data, scale)
  dev.off()

}


walk(names(.levers), ~gen_scales(data, .x))




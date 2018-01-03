library(magrittr)
library(purrr)
library(dplyr)
library(ggplot2)

files <- list.files(file.path("inst", "data"), full.names = TRUE, pattern = "sav")

data <- files %>%
  map_df(~read_tcps(.x))

data %>%
  dplyr::filter_(~type == "lever") %>%
  distinct(survey, PartNum) %>%
  group_by(survey) %>%
  tally()



filter(data, survey == "Staff", item == "instinit")

lever_scale(data, "instinit")

p + scale_fill_manual("", values = c(grey.colors(2))) +
  scale_y_discrete(expand = c(0,0)) +
  theme(strip.text = element_blank(),
        axis.text.y = element_blank(),
        legend.position = "none",
        panel.grid.major = element_blank())


lever_ridgeline(data, aggregate = TRUE) +
  theme(legend.position = "none",
        axis.text.y = element_text(vjust = 0),
        panel.grid.major.x = element_line(linetype = "dashed"),
        panel.grid.major.y = element_blank())


ggplot2::ggsave(filename = "total population ridgeline.png", width = 8, height = 5, units = "in", dpi = 300)


gen_scales <- function(data, scale) {

  Cairo::CairoPDF(sprintf("%s.pdf", scale), width = 22, height = 10) #units = "in", res = 200)
  lever_scale(data, scale)
  dev.off()

}


walk(names(.levers), ~gen_scales(data, .x))







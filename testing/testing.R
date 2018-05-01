library(magrittr)
library(purrr)
library(dplyr)
library(ggplot2)
library(tidyr)

file <- list.files("testing", full.names = TRUE, pattern = "sav")[[2]]

tidy_tcps(file) -> data2

data <- file %>%
  map_dfr(~tidy_tcps(.x))

data %>%
  distinct(PartNum, item, type, scale, .keep_all = TRUE) %>%
  View()

  filter(type == "lever") %>%
  spread(item, value)

data %>%
  dplyr::filter_(~type == "lever") %>%
  distinct(survey, PartNum) %>%
  group_by(survey) %>%
  tally()


tc


tcps_sample %>%
  lever_ridgeline("instinit")

p + scale_fill_manual("", values = c(grey.colors(2))) +
  scale_y_discrete(expand = c(0,0)) +
  theme(strip.text = element_blank(),
        axis.text.y = element_blank(),
        legend.position = "none",
        panel.grid.major = element_blank())


lever_ridgeline(data, lever = "instinit", pal = pal_one)

+
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







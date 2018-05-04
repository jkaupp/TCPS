library(magrittr)
library(purrr)
library(dplyr)
library(ggplot2)
library(tidyr)

file <- list.files("testing", full.names = TRUE, pattern = "sav")[[3]]

tidy_tcps(file) -> data

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



tcps_sample %>%  lever_ridgeline("instinit")




ggplot2::ggsave(filename = "total population ridgeline.png", width = 8, height = 5, units = "in", dpi = 300)


gen_scales <- function(data, scale) {

  Cairo::CairoPDF(sprintf("%s.pdf", scale), width = 22, height = 10) #units = "in", res = 200)
  lever_scale(data, scale)
  dev.off()

}







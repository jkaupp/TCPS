library(magrittr)
library(purrr)
library(dplyr)
library(ggplot2)
library(tidyr)
library(here)

dir <- dir("/Users/jake/Google Drive/Consulting/TCPS/Windsor", pattern = "sav", full.names = TRUE)

file <- dir[[1]]


tidy_tcps_windsor(file) -> data


data %>%  lever_ridgeline("lever2")


ggplot2::ggsave(filename = "total population ridgeline.png", width = 8, height = 5, units = "in", dpi = 300)


gen_scales <- function(data, scale) {

  Cairo::CairoPDF(sprintf("%s.pdf", scale), width = 22, height = 10) #units = "in", res = 200)
  lever_scale(data, scale)
  dev.off()

}







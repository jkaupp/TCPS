library(magrittr)
library(dplyr)
library(purrr)

files <- list.files(file.path("inst", "data"), full.names = TRUE, pattern = "sav")

data <- files %>%
  map(~read_tcps(.x))


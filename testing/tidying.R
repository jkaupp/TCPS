# library(jailbreakr)
# library(rexcel)
# library(tidyverse)
# library(magrittr)
# library(stringi)
#
# file <- list.files("data", full.names = TRUE, pattern = "xlsx")
#
# data <- rexcel::rexcel_read(file) %>%
#   jailbreakr::split_sheet()
#
# values <- map_if(data, ~min(.x$dim) != 1, ~.x$values()) %>%
#   .[map_lgl(., ~!is.null(dim(.x)))] %>%
#   map(as.data.frame)
#
# all_data <- tibble(data = values) %>%
#   mutate(header = map(data, ~unlist(.x) %>%  .[grepl("Q\\d+|Lever",.) & !any(grepl("Statistics",.))])) %>%
#   mutate(header = ifelse(grepl("Lever", header), "Lever", header)) %>%
#   filter(grepl("Q|Lever", header)) %>%
#   separate(header, c("q_type","description"), sep = "\\-") %>%
#   mutate(number = ifelse(grepl("Lever", q_type), NA, parse_number(q_type))) %>%
#   mutate(q_type = stri_extract_first_regex(q_type, "Import|Agree|Lever")) %>%
#   mutate(level = if_else(map_lgl(data, ~any(grepl("Faculty", .x))), "Faculty", "Institution"))
#
#
# item_data <- filter(all_data, q_type != "Lever")
# lever_data <- filter(all_data, q_type == "Lever")
#
# tcps_grad_scales <- item_data %>%
#   mutate(data = map(data, ~mutate_each(.x, funs(gsub("NA", NA, .))))) %>%
#   mutate(data = map(data, ~.x[-1 ,])) %>%
#   mutate(data = map_if(data, level == "Faculty", ~.x[c(-1:-2), c(1:4)])) %>%
#   mutate(data = map_if(data, level == "Faculty", ~setNames(.x, c("faculty", "type", "response","frequency")))) %>%
#   mutate(data = map_if(data, level == "Faculty", ~fill(.x, faculty, type, .direction = "down"))) %>%
#   mutate(data = map_if(data, level != "Faculty", ~.x[-1,c(1:3)])) %>%
#   mutate(data = map_if(data, level != "Faculty", ~setNames(.x, c("type", "response","frequency")))) %>%
#   mutate(data = map_if(data, level != "Faculty", ~fill(.x, type, .direction = "down"))) %>%
#   unnest() %>%
#   map_df(as.character) %>%
#   mutate(item = "Scale") %>%
#   mutate(faculty = ifelse(is.na(faculty), "Queen's", faculty)) %>%
#   rename(n = frequency) %>%
#   select(level, item, number, q_type, description, faculty, type, response, n) %>%
#   filter(type != "Total", response != "Total") %>%
#   mutate(q_type = ifelse(grepl("Agree", q_type), "Agreement", "Importance"))
#
# clean_grad_tcps_lever <- lever_data %>%
#   ungroup %>%
#   select(q_type, level, data) %>%
#   #mutate(faculty = map_if(data, level == "Faculty", ~select(.x, 1) %>% setNames("faculty"))) %>%
#   #mutate(data = map_if(data, level == "Faculty", ~select(.x, -1))) %>%
#   mutate(data = map_if(data, level == "Faculty", ~mutate(.x, V1 = zoo::na.locf(V1)))) %>%
#   mutate(data = map_if(data, level == "Faculty", ~select(.x, c(-9,-11)))) %>%
#   mutate(data = map_if(data, level != "Faculty", ~select(.x, c(-8,-10)))) %>%
#   mutate(data = map_if(data, level == "Faculty", ~setNames(.x, c("faculty" ,"lever" ,"n", "min", "max","mean","std_dev","skewness", "kurtosis")))) %>%
#   mutate(data = map_if(data, level != "Faculty", ~setNames(.x, c("lever" ,"n", "min", "max","mean","std_dev","skewness", "kurtosis")) %>% mutate(faculty = NA))) %>%
#   mutate(data = map(data, ~filter(.x, grepl("Lever", lever))))
#
# tcps_grad_levers <- clean_grad_tcps_lever %>%
#   unnest(data, .drop = FALSE) %>%
#   mutate(faculty = as.character(faculty)) %>%
#   mutate(faculty = ifelse(grepl("NA", faculty), NA, faculty)) %>%
#   mutate(faculty = ifelse(level == "Institution", "Queen's", faculty)) %>%
#   filter(!is.na(faculty),!grepl("statistic|Faculty", faculty)) %>%
#   distinct() %>%
#   separate(lever, c("lever", "description"), sep = ":") %>%
#   mutate(number = parse_number(lever)) %>%
#   mutate(lever = stri_extract_first_regex(lever, "Agreement|Importance")) %>%
#   select(-q_type) %>%
#   rename(q_type = lever) %>%
#   mutate(item = "Lever") %>%
#   select(level, item, number, q_type, description, faculty, n, mean, std_dev) %>%
#   mutate_at(.cols = c("n","mean","std_dev"), funs(as.numeric))
#
# save(tcps_grad_scales, file = "data/tcps_grad_scales.RData")
# save(tcps_grad_levers, file = "data/tcps_grad_levers.RData")
#
#
#
#

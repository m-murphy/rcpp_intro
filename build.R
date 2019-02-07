library(rmarkdown)
library(here)

rmarkdown::render(here("R", "00_rcpp_intro.Rmd"), output_file = here("docs", "rcpp_intro.html"))
rmarkdown::render(here("R", "01_setup.Rmd"), output_file = here("docs", "setup.html"))

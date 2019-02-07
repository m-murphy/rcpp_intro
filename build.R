library(checkpoint)
checkpoint("2019-02-06")

library(rmarkdown)
library(here)

rmarkdown::render_site(here("R", "site"))

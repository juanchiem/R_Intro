set.seed(858)

options(
  digits = 3,
  dplyr.print_max = 6,
  dplyr.print_min = 6,
  width = 90
)

knitr::opts_chunk$set(
  echo = TRUE,
  eval=FALSE,
  comment = "#>",
  collapse = FALSE,
  fig.align = 'center',
  fig.asp = 0.618,  # 1 / phi
  fig.show = "hold",
  warning = FALSE,
  message = FALSE
  # fig.width = 6,
  # fig.height = 4
)

library(kableExtra)
# library(tidyverse)

library(tidyverse)
library(countrycode)
library(purrr)

# in essence unique removes duplicate rows
# filename is "hiv-profile-countries.html
reports <- tibble(
  countries = unique(hiv$iso3),
  filename = stringi::stri_c("hiv-profile-", countries, ".html"),
  params = purrr::map(countries, ~ list(iso3 = .))
)


# stopped working? did not let me run as a chunk in hiv-profile.Rmd
# whereas it did before
# it said error was chunk label 'setup' but could not find for that to be
# the case
# output_dir found via ?render 
reports %>%
  select(output_file = filename, params) %>%
  purrr::pwalk(rmarkdown::render, 
               input = "hiv-profile.Rmd",
               output_dir = "reports")


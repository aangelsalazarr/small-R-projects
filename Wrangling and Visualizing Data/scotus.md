Exploring U.S. Supreme Court Decisions
================
Angel Salazar

## Get the data

``` r
# load useful packages
library(tidyverse)
```

    ## Warning: package 'tidyverse' was built under R version 4.0.5

    ## -- Attaching packages --------------------------------------- tidyverse 1.3.1 --

    ## v ggplot2 3.3.5     v purrr   0.3.4
    ## v tibble  3.1.4     v dplyr   1.0.7
    ## v tidyr   1.1.3     v stringr 1.4.0
    ## v readr   2.0.1     v forcats 0.5.1

    ## Warning: package 'ggplot2' was built under R version 4.0.5

    ## Warning: package 'tibble' was built under R version 4.0.5

    ## Warning: package 'tidyr' was built under R version 4.0.5

    ## Warning: package 'readr' was built under R version 4.0.5

    ## Warning: package 'dplyr' was built under R version 4.0.5

    ## Warning: package 'forcats' was built under R version 4.0.5

    ## -- Conflicts ------------------------------------------ tidyverse_conflicts() --
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

``` r
# load data
scdb_case <- read.csv("C:\\Users\\aange\\OneDrive\\Desktop\\Autumn2021\\ComputingforSOSC\\assignments\\hw03\\data\\scdb-case.csv")
scdb_vote <- read.csv("C:\\Users\\aange\\OneDrive\\Desktop\\Autumn2021\\ComputingforSOSC\\assignments\\hw03\\data\\scdb-vote.csv")
```

## Notes

1.  ‘scdb-case.csv’ contains all *case-level* variables
      - contains one row for every case and one column for every
        variable
2.  ‘scdb-vote.csv’ contains all *vote-level* variables
      - contains one row for every vote by a justice in every case and
        one column for every variable
3.  For our purposes, the only ID variable we need to concern ourselves
    with is *caseIssuesId* but these may also be useful:
      - chief
      - dateDecision
      - decisionDirection
      - decisionType
      - declarationUncon
      - direction
      - issueArea
      - justice
      - justiceName
      - majority
      - majVotes
      - minVotes
      - term

## Recode variables as you find necessary

## What percentage of cases in each term are decided by a one-vote margin (i.e. 5-4, 4-3, etc.)

## For justices [currently serving on the Supreme Court](https://www.supremecourt.gov/about/biographies.aspx), how often have they voted in the conservative direction in cases involving criminal procedure, civil rights, economic activity, and federal taxation?

Organize the resulting graph by justice in descending order of
seniority. (Note that the chief justice is always considered the most
senior member of the court, regardless of appointment date.)

## In each term, how many of the term’s published decisions (decided after oral arguments) were announced in a given month?

## Which justices are most likely to agree with with the Court’s declaration that an act of Congress, a state or territorial law, or a municipal ordinance is unconstitutional? Identify all cases where the Court declared something unconstitutional and determine the ten justices who most and least frequently agreed with this outcome as a percentage of all votes cast by the justice in these cases. Exclude any justice with fewer than 30 votes in cases where the Court’s outcome declares something unconstitutional.

## In each term he served on the Court, in what percentage of cases was Justice Antonin Scalia in the majority?

## Create a graph similar to above that adds a second component which compares the percentage for all cases versus non-unanimous cases (i.e. there was at least one dissenting vote)

## In each term, what percentage of cases were decided in the conservative direction?

## The Chief Justice is frequently seen as capable of influencing the ideological direction of the Court. Create a graph similar to the one above that also incorporates information on who was the Chief Justice during the term.

## Session info

``` r
devtools::session_info()
```

    ## - Session info ---------------------------------------------------------------
    ##  setting  value                       
    ##  version  R version 4.0.3 (2020-10-10)
    ##  os       Windows 10 x64              
    ##  system   x86_64, mingw32             
    ##  ui       RTerm                       
    ##  language (EN)                        
    ##  collate  English_United States.1252  
    ##  ctype    English_United States.1252  
    ##  tz       America/Chicago             
    ##  date     2021-10-18                  
    ## 
    ## - Packages -------------------------------------------------------------------
    ##  package     * version date       lib source        
    ##  assertthat    0.2.1   2019-03-21 [1] CRAN (R 4.0.3)
    ##  backports     1.2.1   2020-12-09 [1] CRAN (R 4.0.3)
    ##  broom         0.7.9   2021-07-27 [1] CRAN (R 4.0.5)
    ##  cachem        1.0.6   2021-08-19 [1] CRAN (R 4.0.5)
    ##  callr         3.7.0   2021-04-20 [1] CRAN (R 4.0.5)
    ##  cellranger    1.1.0   2016-07-27 [1] CRAN (R 4.0.5)
    ##  cli           3.0.1   2021-07-17 [1] CRAN (R 4.0.5)
    ##  colorspace    2.0-2   2021-06-24 [1] CRAN (R 4.0.5)
    ##  crayon        1.4.1   2021-02-08 [1] CRAN (R 4.0.5)
    ##  DBI           1.1.1   2021-01-15 [1] CRAN (R 4.0.5)
    ##  dbplyr        2.1.1   2021-04-06 [1] CRAN (R 4.0.5)
    ##  desc          1.4.0   2021-09-28 [1] CRAN (R 4.0.3)
    ##  devtools      2.4.2   2021-06-07 [1] CRAN (R 4.0.5)
    ##  digest        0.6.27  2020-10-24 [1] CRAN (R 4.0.5)
    ##  dplyr       * 1.0.7   2021-06-18 [1] CRAN (R 4.0.5)
    ##  ellipsis      0.3.2   2021-04-29 [1] CRAN (R 4.0.5)
    ##  evaluate      0.14    2019-05-28 [1] CRAN (R 4.0.3)
    ##  fansi         0.5.0   2021-05-25 [1] CRAN (R 4.0.5)
    ##  fastmap       1.1.0   2021-01-25 [1] CRAN (R 4.0.5)
    ##  forcats     * 0.5.1   2021-01-27 [1] CRAN (R 4.0.5)
    ##  fs            1.5.0   2020-07-31 [1] CRAN (R 4.0.5)
    ##  generics      0.1.0   2020-10-31 [1] CRAN (R 4.0.3)
    ##  ggplot2     * 3.3.5   2021-06-25 [1] CRAN (R 4.0.5)
    ##  glue          1.4.2   2020-08-27 [1] CRAN (R 4.0.3)
    ##  gtable        0.3.0   2019-03-25 [1] CRAN (R 4.0.3)
    ##  haven         2.4.3   2021-08-04 [1] CRAN (R 4.0.5)
    ##  hms           1.1.1   2021-09-26 [1] CRAN (R 4.0.3)
    ##  htmltools     0.5.2   2021-08-25 [1] CRAN (R 4.0.5)
    ##  httr          1.4.2   2020-07-20 [1] CRAN (R 4.0.5)
    ##  jsonlite      1.7.2   2020-12-09 [1] CRAN (R 4.0.3)
    ##  knitr         1.35    2021-09-28 [1] CRAN (R 4.0.3)
    ##  lifecycle     1.0.1   2021-09-24 [1] CRAN (R 4.0.3)
    ##  lubridate     1.7.10  2021-02-26 [1] CRAN (R 4.0.5)
    ##  magrittr      2.0.1   2020-11-17 [1] CRAN (R 4.0.3)
    ##  memoise       2.0.0   2021-01-26 [1] CRAN (R 4.0.5)
    ##  modelr        0.1.8   2020-05-19 [1] CRAN (R 4.0.5)
    ##  munsell       0.5.0   2018-06-12 [1] CRAN (R 4.0.3)
    ##  pillar        1.6.3   2021-09-26 [1] CRAN (R 4.0.3)
    ##  pkgbuild      1.2.0   2020-12-15 [1] CRAN (R 4.0.3)
    ##  pkgconfig     2.0.3   2019-09-22 [1] CRAN (R 4.0.3)
    ##  pkgload       1.2.2   2021-09-11 [1] CRAN (R 4.0.5)
    ##  prettyunits   1.1.1   2020-01-24 [1] CRAN (R 4.0.3)
    ##  processx      3.5.2   2021-04-30 [1] CRAN (R 4.0.5)
    ##  ps            1.6.0   2021-02-28 [1] CRAN (R 4.0.5)
    ##  purrr       * 0.3.4   2020-04-17 [1] CRAN (R 4.0.3)
    ##  R6            2.5.1   2021-08-19 [1] CRAN (R 4.0.5)
    ##  Rcpp          1.0.7   2021-07-07 [1] CRAN (R 4.0.5)
    ##  readr       * 2.0.1   2021-08-10 [1] CRAN (R 4.0.5)
    ##  readxl        1.3.1   2019-03-13 [1] CRAN (R 4.0.5)
    ##  remotes       2.4.0   2021-06-02 [1] CRAN (R 4.0.5)
    ##  reprex        2.0.1   2021-08-05 [1] CRAN (R 4.0.5)
    ##  rlang         0.4.11  2021-04-30 [1] CRAN (R 4.0.5)
    ##  rmarkdown     2.11    2021-09-14 [1] CRAN (R 4.0.5)
    ##  rprojroot     2.0.2   2020-11-15 [1] CRAN (R 4.0.3)
    ##  rstudioapi    0.13    2020-11-12 [1] CRAN (R 4.0.3)
    ##  rvest         1.0.1   2021-07-26 [1] CRAN (R 4.0.5)
    ##  scales        1.1.1   2020-05-11 [1] CRAN (R 4.0.3)
    ##  sessioninfo   1.1.1   2018-11-05 [1] CRAN (R 4.0.5)
    ##  stringi       1.7.4   2021-08-25 [1] CRAN (R 4.0.5)
    ##  stringr     * 1.4.0   2019-02-10 [1] CRAN (R 4.0.3)
    ##  testthat      3.0.4   2021-07-01 [1] CRAN (R 4.0.5)
    ##  tibble      * 3.1.4   2021-08-25 [1] CRAN (R 4.0.5)
    ##  tidyr       * 1.1.3   2021-03-03 [1] CRAN (R 4.0.5)
    ##  tidyselect    1.1.1   2021-04-30 [1] CRAN (R 4.0.5)
    ##  tidyverse   * 1.3.1   2021-04-15 [1] CRAN (R 4.0.5)
    ##  tzdb          0.1.2   2021-07-20 [1] CRAN (R 4.0.5)
    ##  usethis       2.0.1   2021-02-10 [1] CRAN (R 4.0.5)
    ##  utf8          1.2.2   2021-07-24 [1] CRAN (R 4.0.5)
    ##  vctrs         0.3.8   2021-04-29 [1] CRAN (R 4.0.5)
    ##  withr         2.4.2   2021-04-18 [1] CRAN (R 4.0.5)
    ##  xfun          0.24    2021-06-15 [1] CRAN (R 4.0.5)
    ##  xml2          1.3.2   2020-04-23 [1] CRAN (R 4.0.5)
    ##  yaml          2.2.1   2020-02-01 [1] CRAN (R 4.0.3)
    ## 
    ## [1] C:/Users/aange/OneDrive/Documents/R/win-library/4.0
    ## [2] C:/Program Files/R/R-4.0.3/library

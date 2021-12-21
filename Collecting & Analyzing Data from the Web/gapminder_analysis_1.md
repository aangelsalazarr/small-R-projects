part1 - exploring gapminder
================
Angel Salazar
11/26/2021

``` r
## using JSON may be required so this is a precautionary inclusion
library(rjson)

## We want to get the country information using geonames
library(geonames)

## will be using gapminder package
library(gapminder)
```

    ## Warning: package 'gapminder' was built under R version 4.0.5

``` r
## will be using this package to merge dfs
library(dplyr)
```

    ## Warning: package 'dplyr' was built under R version 4.0.5

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
library(tidyverse)
```

    ## Warning: package 'tidyverse' was built under R version 4.0.5

    ## -- Attaching packages --------------------------------------- tidyverse 1.3.1 --

    ## v ggplot2 3.3.5     v purrr   0.3.4
    ## v tibble  3.1.4     v stringr 1.4.0
    ## v tidyr   1.1.4     v forcats 0.5.1
    ## v readr   2.0.1

    ## Warning: package 'ggplot2' was built under R version 4.0.5

    ## Warning: package 'tibble' was built under R version 4.0.5

    ## Warning: package 'tidyr' was built under R version 4.0.5

    ## Warning: package 'readr' was built under R version 4.0.5

    ## Warning: package 'forcats' was built under R version 4.0.5

    ## -- Conflicts ------------------------------------------ tidyverse_conflicts() --
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

``` r
## will need this to merge dfs based on unique key
library(countrycode)
```

    ## Warning: package 'countrycode' was built under R version 4.0.5

``` r
## here we want to create a df for gapminder
gapminder_data <- gapminder

## creating a df for geonames
geonames_data <- GNcountryInfo()

## want to get a glimpse of the df
head(gapminder_data)
```

    ## # A tibble: 6 x 6
    ##   country     continent  year lifeExp      pop gdpPercap
    ##   <fct>       <fct>     <int>   <dbl>    <int>     <dbl>
    ## 1 Afghanistan Asia       1952    28.8  8425333      779.
    ## 2 Afghanistan Asia       1957    30.3  9240934      821.
    ## 3 Afghanistan Asia       1962    32.0 10267083      853.
    ## 4 Afghanistan Asia       1967    34.0 11537966      836.
    ## 5 Afghanistan Asia       1972    36.1 13079460      740.
    ## 6 Afghanistan Asia       1977    38.4 14880372      786.

``` r
head(geonames_data)
```

    ##   continent          capital         languages geonameId            south
    ## 1        EU Andorra la Vella                ca   3041565     42.428743001
    ## 2        AS        Abu Dhabi ar-AE,fa,en,hi,ur    290557 22.6315119400001
    ## 3        AS            Kabul fa-AF,ps,uz-AF,tk   1149361 29.3770645357176
    ## 4        NA     Saint John’s             en-AG   3576396 16.9986381530001
    ## 5        NA       The Valley             en-AI   3573511 18.1602929743117
    ## 6        EU           Tirana             sq,el    783754 39.6448624829142
    ##   isoAlpha3            north fipsCode population              east isoNumeric
    ## 1       AND        42.655765       AN      77006  1.78657600000003        020
    ## 2       ARE 26.0693916590001       AE    9630959      56.381222289        784
    ## 3       AFG 38.4907920755748       AF   37172386  74.8894511481168        004
    ## 4       ATG 17.7291087744312       AC      96286     -61.672164917        028
    ## 5       AIA 18.2769019716581       AV      13254 -62.9665554457795        660
    ## 6       ALB 42.6611669383269       AL    2866376  21.0574334835312        008
    ##   areaInSqKm countryCode              west                     countryName
    ## 1      468.0          AD  1.41376000100007         Principality of Andorra
    ## 2    82880.0          AE  51.5904085340001            United Arab Emirates
    ## 3   647500.0          AF  60.4720833972263 Islamic Republic of Afghanistan
    ## 4      443.0          AG      -61.90630722             Antigua and Barbuda
    ## 5      102.0          AI -63.1680898960388                        Anguilla
    ## 6    28748.0          AL  19.2639112711741             Republic of Albania
    ##   postalCodeFormat continentName currencyCode
    ## 1            AD###        Europe          EUR
    ## 2                           Asia          AED
    ## 3                           Asia          AFN
    ## 4                  North America          XCD
    ## 5                  North America          XCD
    ## 6             ####        Europe          ALL

``` r
## we want to add a column to our df, gapminder that is countryCode
gapminder_data <- mutate(gapminder_data, 
                         countryCode = countrycode(sourcevar = country, 
                                                   origin = "country.name", 
                                                   destination = "iso2c"))
```

``` r
## now we want to apply left_join() via the key of countryCode
data_merged <- inner_join(
  x = gapminder_data, 
  y = geonames_data, 
  by = "countryCode"
)
```

``` r
## plotting life expectancy vs population
data_merged %>%
 mutate(pop = as.integer(pop) / 1e06) %>%
  ggplot(mapping = aes(x = pop, 
                       y = lifeExp)) + 
  labs(x = "Population (in millions)", 
       y = "Average Life Expectancy") +
  geom_point() +
  geom_smooth(method = NULL) 
```

    ## `geom_smooth()` using method = 'gam' and formula 'y ~ s(x, bs = "cs")'

![](gapminder_analysis_1_files/figure-gfm/making%20a%20plot-1.png)<!-- -->

``` r
## plotting life expectancy vs population density
## understand pop density = pop / country area
data_merged %>%
  mutate(population_density = as.integer(population) / as.integer(areaInSqKm)) %>%
  ggplot(mapping = aes(x = population_density, 
                       y = lifeExp)) +
  labs(x = "Population Density (per Square Kilometer)",
       y = "Average Life Expectancy") +
  geom_point() +
  geom_smooth(method = NULL) 
```

    ## `geom_smooth()` using method = 'gam' and formula 'y ~ s(x, bs = "cs")'

![](gapminder_analysis_1_files/figure-gfm/making%20a%20plot-2.png)<!-- -->

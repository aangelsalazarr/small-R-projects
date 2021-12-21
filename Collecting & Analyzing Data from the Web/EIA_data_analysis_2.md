More Complicated Data Collection
================
Angel Salazar
11/29/2021

``` r
## first we want to install and load package, "eia"
## this will allow us to run eia_set_key("yourkey") in the future
library(eia)
```

    ## Warning: package 'eia' was built under R version 4.0.5

``` r
## second we want to install and load package, "EIAdata"
library(EIAdata)
```

    ## Loading required package: XML

    ## Warning: package 'XML' was built under R version 4.0.5

    ## Loading required package: xts

    ## Warning: package 'xts' was built under R version 4.0.5

    ## Loading required package: zoo

    ## Warning: package 'zoo' was built under R version 4.0.5

    ## 
    ## Attaching package: 'zoo'

    ## The following objects are masked from 'package:base':
    ## 
    ##     as.Date, as.Date.numeric

``` r
## other libraries we may need for data analysis
library(ggplot2)
```

    ## Warning: package 'ggplot2' was built under R version 4.0.5

``` r
library(tidyr)
```

    ## Warning: package 'tidyr' was built under R version 4.0.5

``` r
library(rjson)
library(dplyr)
```

    ## Warning: package 'dplyr' was built under R version 4.0.5

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:xts':
    ## 
    ##     first, last

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
## before we begin we must store our API Key to be used within the session
## thus, we will run the following in our console: eia_set_key("yourkey")

## function wngsr will return a list object containing the time the report was
## run, and the contents of the US EIA's Weekly Natural Gas Storage Report
## Function has no argument so just run wngsr()
wngsr()
```

    ## $time_run
    ## [1] "2021-11-30 01:55:51 CST"
    ## 
    ## $wngsr
    ##               19-Nov-21 12-Nov-21 net change (Bcf) implied flow (Bcf)
    ## East                889       900              -11                -11
    ## Midwest            1066      1079              -13                -13
    ## Mountain            210       212               -2                 -2
    ## Pacific             262       261                1                  1
    ## South Central      1197      1191                6                  6
    ##   Salt              338       331                7                  7
    ##   Nonsalt           859       860               -1                 -1
    ## Total              3623      3644              -21                -21
    ##               Year Ago Bcf % Change YoY 5 Yr Avg Bcf % Change from 5 Yr Avg
    ## East                   937         -5.1          890                   -0.1
    ## Midwest               1134         -6.0         1075                   -0.8
    ## Mountain               242        -13.2          220                   -4.5
    ## Pacific                320        -18.1          302                  -13.2
    ## South Central         1311         -8.7         1195                    0.2
    ##   Salt                 355         -4.8          330                    2.4
    ##   Nonsalt              956        -10.1          865                   -0.7
    ## Total                 3943         -8.1         3681                   -1.6

``` r
## this will give us top-level category information
eia_cats()
```

    ## $category
    ## # A tibble: 1 x 3
    ##   category_id name          notes
    ##   <chr>       <chr>         <chr>
    ## 1 371         EIA Data Sets ""   
    ## 
    ## $childcategories
    ## # A tibble: 14 x 2
    ##    category_id name                               
    ##          <int> <chr>                              
    ##  1           0 Electricity                        
    ##  2       40203 State Energy Data System (SEDS)    
    ##  3      714755 Petroleum                          
    ##  4      714804 Natural Gas                        
    ##  5      711224 Total Energy                       
    ##  6      717234 Coal                               
    ##  7      829714 Short-Term Energy Outlook          
    ##  8      964164 Annual Energy Outlook              
    ##  9     1292190 Crude Oil Imports                  
    ## 10     2123635 U.S. Electric System Operating Data
    ## 11     2134384 International Energy Data          
    ## 12     2251604 CO2 Emissions                      
    ## 13     2631064 International Energy Outlook       
    ## 14     2889994 U.S. Nuclear Outages

``` r
# this ID is for data grabbing aka electricity generation by year and all fuels
id_electr_gen <- c("ELEC.GEN.ALL-99.A" ) # Annually

## these are regions as shown in the API Query Browser
regions <- c("East North Central", 
            "East South Central", 
            "Middle Atlantic",
            "Mountain", 
            "South Atlantic",
            "West North Central", 
            "West South Central", 
            "Pacific Noncontiguous", 
            "Pacific Contiguous")

## this is just a list of all US States
region_us_states <- state.name

## here we are attaching out eia_geoset function to x as a complex vector
x <- eia_geoset(id_electr_gen, 
                regions[1], # changing regions[number] allows for other region graphs
                n = 12)

## selecting data from x
select(x, region, data) %>% unnest(cols = data)
```

    ## # A tibble: 60 x 4
    ##    region   value date        year
    ##    <chr>    <dbl> <date>     <int>
    ##  1 USA-IL 173552. 2020-01-01  2020
    ##  2 USA-IL 184470. 2019-01-01  2019
    ##  3 USA-IL 188003. 2018-01-01  2018
    ##  4 USA-IL 183592. 2017-01-01  2017
    ##  5 USA-IL 187289. 2016-01-01  2016
    ##  6 USA-IL 193952. 2015-01-01  2015
    ##  7 USA-IL 202144. 2014-01-01  2014
    ##  8 USA-IL 203005. 2013-01-01  2013
    ##  9 USA-IL 197565. 2012-01-01  2012
    ## 10 USA-IL 199500. 2011-01-01  2011
    ## # ... with 50 more rows

``` r
## plotting our data pertaining to data, where color is by region specified
## breaking up x tick marks to have more years than before
unnest(x, cols = data) %>%
  ggplot(aes(x = date, 
             y = value, 
             color = region)) + 
  scale_x_date(breaks = scales::pretty_breaks(n = 10)) +
  geom_line(size = 1.2) +
  labs(y = x$units[1], 
       title = "Net Electricity Generation (Annually)", 
       subtitle = "From all fuels", 
       color = regions[1])
```

![](EIA_data_analysis_2_files/figure-gfm/us%20electricity%20generation%20by%20region-1.png)<!-- -->

``` r
## first lets run our handy eia_cats()
eia_cats()
```

    ## $category
    ## # A tibble: 1 x 3
    ##   category_id name          notes
    ##   <chr>       <chr>         <chr>
    ## 1 371         EIA Data Sets ""   
    ## 
    ## $childcategories
    ## # A tibble: 14 x 2
    ##    category_id name                               
    ##          <int> <chr>                              
    ##  1           0 Electricity                        
    ##  2       40203 State Energy Data System (SEDS)    
    ##  3      714755 Petroleum                          
    ##  4      714804 Natural Gas                        
    ##  5      711224 Total Energy                       
    ##  6      717234 Coal                               
    ##  7      829714 Short-Term Energy Outlook          
    ##  8      964164 Annual Energy Outlook              
    ##  9     1292190 Crude Oil Imports                  
    ## 10     2123635 U.S. Electric System Operating Data
    ## 11     2134384 International Energy Data          
    ## 12     2251604 CO2 Emissions                      
    ## 13     2631064 International Energy Outlook       
    ## 14     2889994 U.S. Nuclear Outages

``` r
## Now let's say we are interesting in short term energy outlook
## notice the category id = 829714
eia_cats(829714)
```

    ## $category
    ## # A tibble: 1 x 4
    ##   category_id parent_category_id name                      notes
    ##   <chr>       <chr>              <chr>                     <chr>
    ## 1 829714      371                Short-Term Energy Outlook ""   
    ## 
    ## $childcategories
    ## # A tibble: 10 x 2
    ##    category_id name                                     
    ##          <int> <chr>                                    
    ##  1      829715 U.S. Prices                              
    ##  2      829716 International Petroleum and Other Liquids
    ##  3      829717 U.S. Petroleum and Other Liquids         
    ##  4      829718 U.S. Natural Gas                         
    ##  5      829719 U.S. Electricity                         
    ##  6      829720 U.S. Coal                                
    ##  7      829721 U.S. Renewable Energy                    
    ##  8     1039844 U.S. CO<SUB>2</SUB> Emissions            
    ##  9      829723 U.S. Weather                             
    ## 10      829724 U.S. Economy

``` r
## after running above, which looks into sub category of short term energy outlook
## we know see more options that are like sub-sub categories
## let's say we are interested in U.S. Prices and U.S Emissions
## former has category id = 829715 and latter id = 1039844
## let's focus on less boring, aka emissions
eia_cats(1039844)
```

    ## $category
    ## # A tibble: 1 x 4
    ##   category_id parent_category_id name                          notes
    ##   <chr>       <chr>              <chr>                         <chr>
    ## 1 1039844     829714             U.S. CO<SUB>2</SUB> Emissions ""   
    ## 
    ## $childseries
    ## # A tibble: 15 x 5
    ##    series_id      name                             f     units      updated     
    ##    <chr>          <chr>                            <chr> <chr>      <chr>       
    ##  1 STEO.CXTCCO2.A Carbon Dioxide Emissions from C~ A     million m~ 09-NOV-21 0~
    ##  2 STEO.CXTCCO2.M Carbon Dioxide Emissions from C~ M     million m~ 09-NOV-21 0~
    ##  3 STEO.CXTCCO2.Q Carbon Dioxide Emissions from C~ Q     million m~ 09-NOV-21 0~
    ##  4 STEO.FFTCCO2.A Carbon Dioxide Emissions from F~ A     million m~ 09-NOV-21 0~
    ##  5 STEO.FFTCCO2.M Carbon Dioxide Emissions from F~ M     million m~ 09-NOV-21 0~
    ##  6 STEO.FFTCCO2.Q Carbon Dioxide Emissions from F~ Q     million m~ 09-NOV-21 0~
    ##  7 STEO.NGTCCO2.A Carbon Dioxide Emissions from N~ A     million m~ 09-NOV-21 0~
    ##  8 STEO.NGTCCO2.M Carbon Dioxide Emissions from N~ M     million m~ 09-NOV-21 0~
    ##  9 STEO.NGTCCO2.Q Carbon Dioxide Emissions from N~ Q     million m~ 09-NOV-21 0~
    ## 10 STEO.PATCCO2.A Carbon Dioxide Emissions from P~ A     million m~ 09-NOV-21 0~
    ## 11 STEO.PATCCO2.M Carbon Dioxide Emissions from P~ M     million m~ 09-NOV-21 0~
    ## 12 STEO.PATCCO2.Q Carbon Dioxide Emissions from P~ Q     million m~ 09-NOV-21 0~
    ## 13 STEO.TETCCO2.A Total Energy CO2 Emissions, Ann~ A     million m~ 09-NOV-21 0~
    ## 14 STEO.TETCCO2.M Total Energy CO2 Emissions, Mon~ M     million m~ 09-NOV-21 0~
    ## 15 STEO.TETCCO2.Q Total Energy CO2 Emissions, Qua~ Q     million m~ 09-NOV-21 0~

``` r
## after running above code we get more subsets, best thing to note is last letter
## is associated as follows
## A = Annual , M = Monthly, and Q = Quarterly

## I wanna know more about Annual and looking at all energy emissions
## so i will note series_id = STEO.TETCCO2.A on 2nd page

## lets create our lil complex vector but first run ?eia_series to get better help
vector_emissions_annual <- eia_series(id = "STEO.TETCCO2.A")

## okay we have it! now let's look at how our data is structured
str(vector_emissions_annual$data)
```

    ## List of 1
    ##  $ : tibble [33 x 3] (S3: tbl_df/tbl/data.frame)
    ##   ..$ value: num [1:33] 4920 4886 4575 5144 5277 ...
    ##   ..$ date : Date[1:33], format: "2022-01-01" "2021-01-01" ...
    ##   ..$ year : int [1:33] 2022 2021 2020 2019 2018 2017 2016 2015 2014 2013 ...

``` r
## let's note columns are value, date, and year up to 2022 (short term for sure)

# unnesting the three nested data columns
select(vector_emissions_annual, 
       data) %>% unnest(cols = data)
```

    ## # A tibble: 33 x 3
    ##    value date        year
    ##    <dbl> <date>     <int>
    ##  1 4920. 2022-01-01  2022
    ##  2 4886. 2021-01-01  2021
    ##  3 4575. 2020-01-01  2020
    ##  4 5144. 2019-01-01  2019
    ##  5 5277. 2018-01-01  2018
    ##  6 5131. 2017-01-01  2017
    ##  7 5169. 2016-01-01  2016
    ##  8 5262. 2015-01-01  2015
    ##  9 5414. 2014-01-01  2014
    ## 10 5359. 2013-01-01  2013
    ## # ... with 23 more rows

``` r
# unnesting and plotting our data
unnest(vector_emissions_annual, 
       cols = data) %>%
  ggplot(aes(x = date, 
             y = value)) + 
  scale_x_date(breaks = scales::pretty_breaks(n=15)) +
  scale_y_continuous(breaks = scales::pretty_breaks(n=10)) + 
  ylim(4000, 6500) +
  geom_line(size = 2) + # size = 10 looks super comical
  labs(y = vector_emissions_annual$units[1], 
       title = "U.S. Total Energy CO2 Emissions, Annual", 
       subtitle = "Note: Pandemic Heavily Impacted Energy Use and Production in 2020")
```

    ## Scale for 'y' is already present. Adding another scale for 'y', which will
    ## replace the existing scale.

![](EIA_data_analysis_2_files/figure-gfm/category%20exploration%20when%20you%20are%20lazy%20to%20go%20to%20website-1.png)<!-- -->

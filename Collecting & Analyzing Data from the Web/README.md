## **Homework 8: Collecting and Analyzing Data from the Web**
#### *Author: Angel Salazar*
***

### Packages Used:
1. Gapminder & Geonames Data Analysis
    - library(rjson)
    - library(geonames)
    - library(gapminder)
    - library(dplyr)
    - library(tidyverse)
    - library(countrycode)
    
2. Energy Information Administration (EIA) Data Analysis
    - library(eia)
    - library(EIAdata)
    - library(ggplot2)
    - library(tidyr)
    - library(rjson)
    - library(dplyr)
    
### API Key Setup and Use
- [Register for an EIA API Key Here](https://www.eia.gov/opendata/register.cfm)
- Install and run required packages
- Insert the following in your R Console: eia_set_key("yourkey", store = "sysenv")
- Yay! Your API Key has been processed for the duration of your R Session

***
### **Gapminder & Geonames Data Analysis**
#### [Geonames Website](http://www.geonames.org/)
##### *Resources*
1. [Mutating Joins](https://dplyr.tidyverse.org/reference/mutate-joins.html)
2. [Country Code Function](https://www.rdocumentation.org/packages/countrycode/versions/1.2.0/topics/countrycode)

***
### **Energy Information Administration (EIA) Data Analysis**
#### [Energy Information Administration (EIA)](https://www.eia.gov/opendata/)
##### *Resources*
1. [EIA Package](https://cran.r-project.org/web/packages/eia/eia.pdf)
2. [ggplot Axis editing](http://www.sthda.com/english/wiki/ggplot2-axis-scales-and-transformations)
3. [Nesting](https://bookdown.org/Maxine/r4ds/nesting.html)
4. [ggplot Cheatsheet](https://www.maths.usyd.edu.au/u/UG/SM/STAT3022/r/current/Misc/data-visualization-2.1.pdf)

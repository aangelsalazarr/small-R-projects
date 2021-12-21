# meant to produce figures and store them

knitr::opts_chunk$set(echo = TRUE)

# importing necessary libraries
library(ggplot2)
library(dplyr)
library(tidyverse)

# here we are plotting energy consumption and production and differentiating by
# if the energy data is consumption or production
# overall we don't need total values because it makes data less readable
usenergy %>%
  filter (fueltype != "total") %>%
  ggplot() + geom_line(aes(x = year, 
                           y = quads, 
                           color = fueltype)) + 
  labs(x = "Year", y = "quads", title = "Energy Consumption and Production by Fuel Type, 
       USA 2020 - 2050") + theme(legend.position = "bottom") +
  facet_grid(cols=vars(result))

# plotting the binded df
export_import %>%
  filter (fueltype != "total") %>%
  ggplot() + geom_line(aes(x = year, 
                           y = quads, 
                           color = fueltype)) + 
  labs(x = "Year", y = "quads", title = "Energy Exports/Imports by Fuel Type, 
       USA 2020 - 2050") + theme(legend.position = "bottom") +
  facet_grid(cols = vars(direction))

# plotting indexes forecast
energy_real_prices %>%
  ggplot() + geom_line(aes(x = year, 
                           y = price, 
                           color = index)) + 
  labs(x = "Year", y = "price", title = "Energy Real Prices by Index, 
       USA 2020 - 2050") + theme(legend.position = "bottom")

# plotting emissions by fuel type
emissions %>%
  filter (fueltype != "total") %>%
  ggplot() + geom_line(aes(x = year, 
                           y = mmotco2, 
                           color = fueltype)) + 
  labs(x = "Year", y = "MMmt CO2", title = "Carbon Emissions by Fuel Type, 
       USA 2020 - 2050") + theme(legend.position = "bottom")

# binded plots differentiated by status
capacity_overview %>%
  filter (type != "total") %>%
  ggplot() + geom_line(aes(x = year, 
                           y = gw, 
                           color = type)) + 
  labs(x = "Year", y = "Gigawatts", title = "Energy Capacity by Type, 
       USA 2020 - 2050") + theme(legend.position = "bottom") +
  facet_grid(cols = vars(status))

# plotting global energy use
energy_use_global %>%
  ggplot() + geom_line(aes(x = year, 
                           y = quadbtu,
                           color = region)) + 
  labs(x = "Year", y = "quad Btu", title = "Global Energy Use, 2010 - 2050") +
  theme(legend.position = "bottom")

# plotting oecd emissions
world_emissions %>%
  filter(region != "total") %>%
  ggplot() + geom_line(aes(x = year,
                           y = MMmt, 
                           color = region)) + 
  labs(x = "Year", y = "MMmt CO2", title = "Global Carbon Emissions by Economic Region,
       2010 - 2050") + theme(legend.position = "bottom") +
  facet_grid(cols=vars(econ_type))
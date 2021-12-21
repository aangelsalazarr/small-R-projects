library(tidyverse)
library(babynames)
library(glue)
library(RColorBrewer)

# plot total US births using a stacked area chart
# in essence, we changed geom_ribbon to geom_area
# geom_area() allows for ymin = 0 and y to be used instead of y_max
# this makes it easier to do stacked chart with n_all variable set as y
applicants %>%
  mutate(
    sex = if_else(sex == "F", "Female", "Male"),
    n_all = n_all / 1e06 # to put into millions scale
  ) %>%
  ggplot(mapping = aes(x = year, y = n_all, fill = sex)) +
  geom_area() +
  scale_fill_brewer(type = "qual") +
  labs(
    title = "Total US births",
    x = "Year",
    y = "Millions",
    fill = NULL,
    caption = "Source: Social Security Administration"
  ) +
  theme_minimal()


# write function to show trends over time for specific name
# fixed glue function by first looking at ?glue
name_trend <- function(person_name) {
  babynames %>%
    filter(name == person_name) %>%
    ggplot(mapping = aes(x = year, y = n, color = sex)) +
    geom_line() +
    scale_color_brewer(type = "qual") +
    labs(
      title = glue('Name: {person_name}'),
      x = "Year",
      y = "Number of births",
      color = NULL
    ) +
    theme_minimal()
}

name_trend("Angel")
name_trend("Sarah")
name_trend("Jesus")


# write function to show trends over time for top N names in a specific year
top_n_trend <- function(n_year, n_rank = 5) {
  # create lookup table
  top_names <- babynames %>%
    group_by(name, sex) %>%
    summarize(count = as.numeric(sum(n))) %>%
    filter(count > 1000) %>%
    select(name, sex)
  
  # filter babynames for top_names
  filtered_names <- babynames %>%
    inner_join(top_names)
  
  # get the top N names from n_year
  top_names <- filtered_names %>%
    filter(year == n_year) %>%
    group_by(name, sex) %>%
    summarize(count = sum(n)) %>%
    group_by(sex) %>%
    mutate(rank = min_rank(desc(count))) %>%
    filter(rank <= n_rank) %>%
    arrange(sex, rank) %>%
    select(name, sex, rank)
  
  # need to increase n colors in palette to be much greater than 12
  # need to install RColorBrewer and then add as library
  mycolors = colorRampPalette(brewer.pal(12, 
                                         "Set3"))(25)
  
  # keep just the top N names over time and plot
  filtered_names %>%
    inner_join(select(top_names, sex, name)) %>%
    ggplot(mapping = aes(x = year, y = n, color = name)) +
    facet_wrap(~sex, ncol = 1) +
    geom_line() +
    scale_color_manual(values = mycolors) +
    labs(
      title = glue("Most Popular Names of {n_year}"),
      x = "Year",
      y = "Number of births",
      color = "Name"
    ) +
    theme_minimal()
}

top_n_trend(n_year = 1986)
top_n_trend(n_year = 2014)

# In RColorBrewer::brewer.pal(n, pal) :
# n too large, allowed maximum for palette Set3 is 12
# after debugging get this:
# Error in colorRamp(colors, ...) : unused argument (n = 8)
top_n_trend(n_year = 1986, n_rank = 10)

# compare naming trends to disney princess film releases
# Error: Must specify at least one column using the `~name` syntax.
# seems logical to make this the first row
disney <- tribble(
  ~"princess",  ~"film", ~"release_year",
  "Snow White", "Snow White and the Seven Dwarfs", 1937,
  "Cinderella", "Cinderella", 1950,
  "Aurora", "Sleeping Beauty", 1959,
  "Ariel", "The Little Mermaid", 1989,
  "Belle", "Beauty and the Beast", 1991,
  "Jasmine", "Aladdin", 1992,
  "Pocahontas", "Pocahontas", 1995,
  "Mulan", "Mulan", 1998,
  "Tiana", "The Princess and the Frog", 2009,
  "Rapunzel", "Tangled", 2010,
  "Merida", "Brave", 2012,
  "Elsa", "Frozen", 2013,
  "Moana", "Moana", 2016
)

## join together the data frames
# [1] Error in label_value(labels, multi_line = multi_line) : argument "labels" 
#   is missing, with no default
# label should be ~name and film so one of these is causing the error
# [2] now we have Error: Faceting variables must have at least one value
# ~ name -> ~name and setting sex == 'F" instead of F

babynames %>%
  # ignore men named after princesses - is this fair?
  filter(sex == 'F') %>%
  inner_join(disney, 
             by = c("name" = "princess")) %>%
  mutate(name = fct_reorder(.f = name, .x = release_year)) %>%
  # plot the trends over time, indicating release year
  ggplot(mapping = aes(x = year, 
                       y = n)) +
  facet_wrap(~name + film, scales = "free_y", 
             labeller = label_both) +
  geom_line() +
  geom_vline(mapping = aes(xintercept = release_year), 
             linetype = 2, 
             alpha = .5) +
  scale_x_continuous(breaks = c(1880, 1940, 2000)) +
  theme_minimal() +
  labs(title = "Popularity of Disney princess names",
       x = "Year",
       y = "Number of births")

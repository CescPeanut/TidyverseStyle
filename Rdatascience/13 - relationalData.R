library(nycflights13)
library(dplyr)
library(readr)
# All the datasets we need to use
flights
airports
planes
weather
airlines

# Identify whether the key is unique or not
flights %>%
  count(tailnum) %>%
  filter(n>2)
planes %>%
  count(tailnum) %>%
  filter(n>2)

# Creat a smaller dataset
flights2 <- flights %>% 
  select(year:day, hour, origin, dest, tailnum, carrier)
flights2

# Join variables
flights2 %>%
  select(-origin, -dest) %>% 
  left_join(airlines, by = "carrier")


# Understanding Joins:
# inner_join, outer_join(left_join, right_join, full_join)
x <- tribble(
  ~key, ~val_x,
  1, "x1",
  2, "x2",
  3, "x3"
)
y <- tribble(
  ~key, ~val_y,
  1, "y1",
  2, "y2",
  4, "y3"
)
x
y
x %>% 
  inner_join(y, by = "key")
x %>% 
  left_join(y, by = "key")
x %>% 
  right_join(y, by = "key")
x %>% 
  full_join(y, by = "key")
# The key may well not be duplicate


# Natural join: use all variables that appear in both tables
# by = NULL
flights2 %>% 
  left_join(weather, by = NULL)

# When the variable names are different in two datasets
flights2 %>% 
  left_join(airports, c("dest" = "faa"))


# Filtering joins
top_dest <- flights %>%
  count(dest, sort = TRUE) %>%
  head(10)
top_dest

flights %>% 
  filter(dest %in% top_dest$dest)
# Better way when there are more than 1 variable: semi-join
flights %>% 
  semi_join(top_dest)


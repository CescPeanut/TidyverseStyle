library(nycflights13) # flights data
library(dplyr)
library(ggplot2)
library(tidyr)

# Filter rows to pick observations
jan1 <- filter(flights, month == 1 | month == 12, day == 1)
jan2 <- filter(flights, month %in% c(1,2,3), day == 1)

# THE DIFFERENCE BETWEEN "|" AND "||"(ALSO "&" AND "&&")
# SIMPLE SIGNAL IS VECTORIZED.

# Arrange rows to reorder them
jan <- arrange(flights, year, month, day, desc(dep_delay))
# the default order is increasing while you can use 'desc' to make a change

# Select columns to pick variables
jan <- select(flights, year, month, day)
jan <- select(flights, year:day)
jan <- select(flights, -(year:day))
# Useful commands:
# starts_with('abc'), ends_with('xyz'), contains('jkl'),
# matches("(.)\\1"), num_range("x", 1:3)

# matches() can select variables that match a regular expression!

# Mutate to creat new variables
flights_sml <- select(flights, 
                      year:day, 
                      ends_with("delay"), 
                      distance, 
                      air_time
)
mutate(flights_sml,
       gain = dep_delay - arr_delay,
       speed = distance / air_time * 60
)
#If you only want to keep the new variables, use transmute().
# '%/%' means integer division and '%%' returns remainder

# Useful functions
# lag() and lead()
x <- 1:10
lag(x)
lead(x)

cumsum(x)
cummean(x)
cumprod(x)

y <- c(22,67,33,23,12,17)
min_rank(y)
min_rank(desc(y))

# Process the data by groups
# Grouped summaries to collapse many values down to a single summary
by_day <- group_by(flights, year, month, day)
summarise(by_day, delay = mean(dep_delay, na.rm = TRUE))

by_month <- flights %>%
  group_by(month) %>%
  summarise(delay = mean(dep_delay, na.rm = TRUE), n = n()) %>%
  mutate(month = as.factor(month))

ggplot(by_month, mapping = aes(x = month, y = delay)) + 
  geom_point(alpha = 1/3, aes(size = n))


# Pipe approach
by_dest <- group_by(flights, dest)
delay <- summarise(by_dest,
                   count = n(),
                   dist = mean(distance, na.rm = TRUE),
                   delay = mean(arr_delay, na.rm = TRUE)
)
delay <- filter(delay, count > 20, dest != "HNL")
ggplot(data = delay, mapping = aes(x = dist, y = delay)) +
  geom_point(aes(size = count), alpha = 1/3) +
  geom_smooth(se = FALSE)

# Tips: group_by() always appears with summarise()
flights_sml %>% 
  group_by(year, month, day) %>%
  filter(rank(desc(arr_delay)) < 10)


# exericise
flights %>%
  group_by(carrier) %>%
  summarise(num = n()) %>%
  ggplot() + 
  geom_bar(mapping = aes(x=reorder(carrier,num,FUN = median), y=num, fill = carrier), stat = "identity") +
  labs(x = 'Carrier', y = 'Count')

  

library(ggplot2)
library(dplyr)

# Compute how many observations occurred with each x value
count(diamonds, cut)

# For continuous variable
diamonds %>% 
  count(cut_width(carat, 0.5))
# Visualisation
ggplot(data = diamonds) +
  geom_histogram(mapping = aes(x = carat), binwidth = 0.5)


# generate a new tibble
smaller <- diamonds %>% 
  filter(carat < 3)

# Handle the outliers
diamonds2 <- diamonds %>% 
  mutate(y = ifelse(y < 3 | y > 20, NA, y))
ggplot(data = diamonds2, mapping = aes(x = x, y = y)) + 
  geom_point(na.rm = TRUE)

# Boxplot
ggplot(data = diamonds, mapping = aes(x = cut, y = price)) +
  geom_boxplot()
# reorder boxplot
ggplot(data = mpg) +
  geom_boxplot(mapping = aes(x = reorder(class, hwy, FUN = median), y = hwy))
# flip the boxplot(which makes it look better)
ggplot(data = mpg) +
  geom_boxplot(mapping = aes(x = reorder(class, hwy, FUN = median), y = hwy)) +
  coord_flip()

# Two quality variables
diamonds %>% 
  count(color, cut)

# geom_tile: an advanced picture
diamonds %>% 
  count(color, cut) %>%  
  ggplot(mapping = aes(x = color, y = cut)) +
  geom_tile(mapping = aes(fill = n))

# Two quantitative variables
# Fix the problem of having too many points
# use alpha command
ggplot(data = diamonds) + 
  geom_point(mapping = aes(x = carat, y = price), alpha = 1 / 100)

# discretize the continuous variable
ggplot(data = smaller, mapping = aes(x = carat, y = price)) + 
  geom_boxplot(mapping = aes(group = cut_width(carat, 0.3)))

 
# Find out covariation after removing the influence
# of another variable
library(modelr)
mod <- lm(log(price) ~ log(carat), data = diamonds)
diamonds2 <- diamonds %>% 
  add_residuals(mod) %>% 
  mutate(resid = exp(resid))
ggplot(data = diamonds2) + 
  geom_boxplot(mapping = aes(x = cut, y = resid))
# What we've done above removes the influence of carat
# when we want to find the covariation between cut and price

# ggplot2: concise expression
diamonds %>% 
  count(cut, clarity) %>% 
  ggplot(aes(clarity, cut, fill = n)) + 
  geom_tile()


# exercise
stocks <- tibble(
  year   = c(2015, 2015, 2015, 2015, 2016, 2016, 2016),
  qtr    = c(   1,    2,    3,    4,    2,    3,    4),
  return = c(1.88, 0.59, 0.35,   NA, 0.92, 0.17, 2.66)
)

library(tidyr)
View(who)
who1 <- who %>%
  gather(starts_with('new'), key = 'key', value = 'cases', na.rm = T)
tmp <- who1 %>%
  count(key)

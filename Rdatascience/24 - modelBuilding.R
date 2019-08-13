library(nycflights13)
library(lubridate)
library(modelr)
library(dplyr)
library(ggplot2)

# low quality diamonds(poor cuts, bad colors, and inferior clarity)
# have higher prices
ggplot(diamonds, aes(cut, price)) + geom_boxplot()
ggplot(diamonds, aes(color, price)) + geom_boxplot()
ggplot(diamonds, aes(clarity, price)) + geom_boxplot()

# view
diamonds

# price and carat
ggplot(diamonds, aes(x = carat, y = price)) + 
  geom_point(alpha = 1/20)


# make a couple of tweaks
diamonds2 <- diamonds %>% 
  filter(carat <= 2.5) %>% 
  mutate(lprice = log2(price), lcarat = log2(carat))

# plot again
ggplot(diamonds2, aes(lcarat, lprice)) + 
  geom_hex(bins = 50)

# remove the strong linear pattern
mod_diamond <- lm(lprice ~ lcarat, data = diamonds2)

# check if we successfully remove the linear pattern
diamonds2 <- diamonds2 %>% 
  add_residuals(mod_diamond, "lresid")

ggplot(diamonds2, aes(lcarat, lresid)) + 
  geom_hex(bins = 50)

# check the result after removing the most influential variable
ggplot(diamonds2, aes(cut, lresid)) + geom_boxplot()
ggplot(diamonds2, aes(color, lresid)) + geom_boxplot()
ggplot(diamonds2, aes(clarity, lresid)) + geom_boxplot()


# multiple variable model
mod_diamond2 <- lm(lprice ~ lcarat + color + cut + clarity, data = diamonds2)

# Visualise
grid <- diamonds2 %>% 
  data_grid(cut, .model = mod_diamond2) %>% 
  add_predictions(mod_diamond2)
grid

ggplot(grid, aes(cut, pred)) + 
  geom_point()


# look at unusual values individually
diamonds2 <- diamonds2 %>% 
  add_residuals(mod_diamond2, "lresid2")

diamonds2 %>% 
  filter(abs(lresid2) > 1) %>% 
  add_predictions(mod_diamond2) %>% 
  mutate(pred = round(2 ^ pred)) %>% 
  select(price, pred, carat:table, x:z) %>% 
  arrange(price)


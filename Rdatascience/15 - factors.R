library(forcats)
library(readr)
library(ggplot2)
# a package for dealing with factors

# Creat factors
month_levels <- c(
  "Jan", "Feb", "Mar", "Apr", "May", "Jun", 
  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
)
x1 <- c("Dec", "Apr", "Jan", "Mar")
y1 <- factor(x1, levels = month_levels)
sort(y1)

x2 <- c("Dec", "Apr", "Jam", "Mar")
y2 <- parse_factor(x2, levels = month_levels)


# General social survey
# example
gss_cat %>%
  count(race)

# modifying factor level
relig_summary <- gss_cat %>%
  group_by(relig) %>%
  summarise(
    age = mean(age, na.rm = TRUE),
    tvhours = mean(tvhours, na.rm = TRUE),
    n = n()
  )

# these two results are different
ggplot(relig_summary, aes(tvhours, relig)) + geom_point()
ggplot(relig_summary, aes(tvhours, fct_reorder(relig, tvhours))) +
  geom_point()

# A more recommended way
relig_summary %>%
  mutate(relig = fct_reorder(relig, tvhours)) %>%
  ggplot(aes(tvhours, relig)) +
  geom_point()

# example
by_age <- gss_cat %>%
  filter(!is.na(age)) %>%
  count(age, marital) %>%
  group_by(age) %>%
  mutate(prop = n / sum(n))

ggplot(by_age, aes(age, prop, colour = fct_reorder2(marital, age, prop))) +
  geom_line() +
  labs(colour = "marital")


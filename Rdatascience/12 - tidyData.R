library(tidyr)
library(dplyr)
library(ggplot2)

## Mutate
table1 %>% 
  mutate(rate = cases / population * 10000)

## Compute cases per year
table1 %>% 
  count(year, wt = cases)

## Visualise changes over time
ggplot(table1, aes(year, cases)) + 
  geom_line(aes(group = country), colour = "grey50") + 
  geom_point(aes(colour = country))


# Gathering: Column to cell
table4a
tidy4a <- table4a %>% 
  gather(c(`1999`, `2000`), key = "year", value = "cases")
tidy4a

table4b
tidy4b <- table4b %>% 
  gather(`1999`, `2000`, key = "year", value = "population")
tidy4b
# Join two datasets
left_join(tidy4a, tidy4b)

# Spreading: Cell to column
table2
table2 %>%
  spread(key = type, value = count)

### Gathering and spreading both intend to generate variables


# Separate
table3
table3 %>% 
  separate(rate, into = c("cases", "population"), sep = "/")
### 'sep' is a regular expression
table3 %>% 
  separate(rate, into = c("cases", "population"), sep = "/",
           convert = T)
### 'sep' can also be the location where you want to make a separation.

# Unite: inverse operation of separate()
table5
table5 %>% 
  unite(new, century, year, sep = "")


# A study case
who <- who
## Reduce the redundant variables
who1 <- who %>% 
  gather(new_sp_m014:newrel_f65, key = "key", value = "cases", na.rm = TRUE)
who1
## Compute the number of keys
who1 %>% 
  count(key)

## replace a part of string through str_replace()
who2 <- who1 %>% 
  mutate(key = stringr::str_replace(key, "newrel", "new_rel"))
who2

## Split the codes
who3 <- who2 %>% 
  separate(key, c("new", "type", "sexage"), sep = "_")
who3

## drop invalid variables
who4 <- who3 %>% 
  select(-new, -iso2, -iso3)

## what's the usage of 'sep = 1'
who5 <- who4 %>% 
  separate(sexage, c("sex", "age"), sep = 1)
who5

# What we've done above is completely the same as:
who %>%
  gather(key, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>% 
  mutate(key = stringr::str_replace(key, "newrel", "new_rel")) %>%
  separate(key, c("new", "var", "sexage")) %>% 
  select(-new, -iso2, -iso3) %>% 
  separate(sexage, c("sex", "age"), sep = 1)


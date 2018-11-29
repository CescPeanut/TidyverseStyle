library(tidyverse)
library(stringr)

x <- c("apple", "banana", "pear")

# "." is used to match everything.
# "/" is used as an "escape", which means
# we can use a "/." to match a ".".
# ^ to match the start of the string.
# $ to match the end of the string.
# To force a regular expression to only match a complete string, 
# anchor it with both ^ and $

# \d: matches any digit.
# \s: matches any whitespace (e.g. space, tab, newline).
# [abc]: matches a, b, or c.
# [^abc]: matches anything except a, b, or c.

# 调整正则表达式regex()的表示形式，检查结果的差异
str_view(c("grey", "gray"), regex("gr(e|a)y"))
str_view(c("211ab3c", "asd", "cc258c", "1a"), "[1-9]*")


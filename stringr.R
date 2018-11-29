library(tidyverse)
library(stringr)

# Basics
string1 <- "This is a string"
string2 <- 'If I want to include a "quote" inside a string, I use single quotes'
double_quote <- "\""

# 字符串长度
str_length(c("a", "R for data science", NA))
# 1 18 NA

# 连接字符串
str_c("x", "歪", "z")
# "x歪z", 可使用sep选项控制字符间隔
# 向量中的连接
str_c("prefix-", c("a", "b", "c"), "-suffix")
# "prefix-a-suffix" "prefix-b-suffix" "prefix-c-suffix"
# 连接向量中的元素
str_c(c("x", "y", "z"), collapse = ", ")

# 字符串提取
x <- "Apple"
str_sub(x, 1, 3)
# "App"

# See others
# paste(), paste0(), str_wrap(),
# str_trim()
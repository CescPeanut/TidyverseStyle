library(tidyverse)    # 程序包：极乐净土
library(nycflights13) # 程序包：一个数据集

# 普通写法
by_dest <- group_by(flights, dest)
delay <- summarise(by_dest,
                   count = n(),
                   dist = mean(distance, na.rm = TRUE),
                   delay = mean(arr_delay, na.rm = TRUE)
)
delay <- filter(delay, count > 20, dest != "HNL")

# Tidyverse写法:use %>%
delays <- flights %>% 
  group_by(dest) %>% 
  summarise(
    count = n(),
    dist = mean(distance, na.rm = TRUE),
    delay = mean(arr_delay, na.rm = TRUE)
  ) %>% 
  filter(count > 20, dest != "HNL")

# Explain: x %>% f(y) turns into f(x, y), and x %>% f(y) %>% g(z) turns 
# into g(f(x, y), z) and so on.


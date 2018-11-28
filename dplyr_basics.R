library(tidyverse)    # 程序包：极乐净土
library(nycflights13) # 程序包：一个数据集

# 加载数据
flights <- flights

# Tidyverse简明化编程风格之dyplr包
# Pick observations by their values (filter()).
# Reorder the rows (arrange()).
# Pick variables by their names (select()).
# Create new variables with functions of existing variables (mutate()).
# Collapse many values down to a single summary (summarise()).


# 使用filter()选取符合条件的观测
jan1 <- filter(flights, month == 1, day == 1)

# "约等于"函数
near(sqrt(2) ^ 2,  2)

# filter()添加逻辑连接，编程更加简明
filter(flights, month %in% c(11, 12))
filter(flights, !(arr_delay > 120 | dep_delay > 120))
filter(flights, arr_delay <= 120, dep_delay <= 120)

# 学习tibble()和filter()
df <- tibble(x = c(1, NA, 3))
filter(df, x > 1)

# 学习between()
x <- rnorm(1e2)
x[between(x, -1, 1)]

# Arrange rows with arrange()
# Learn more on https://r4ds.had.co.nz
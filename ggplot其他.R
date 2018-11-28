library(tidyverse)    # 程序包：极乐净土

# 直方图
ggplot(data = diamonds) +
  geom_histogram(mapping = aes(x = carat), binwidth = 0.5)

# 箱线图
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot()

# 条形图，扇形图***
bar <- ggplot(data = diamonds) + 
  geom_bar(
    mapping = aes(x = cut, fill = cut), 
    show.legend = FALSE,
    width = 1
  ) + 
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)

bar + coord_flip()
bar + coord_polar()
# 扇形图和箱线图有一样的效果


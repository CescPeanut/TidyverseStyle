library(tidyverse) # 程序包：极乐净土

diamonds <- diamonds # R自带钻石数据集

# 分类变量：计数柱状图
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut))

# 自制柱状图
demo <- tribble(        # dplyr包的函数，快速产生小型数据框
  ~cut,         ~freq,
  "Fair",       1610,
  "Good",       4906,
  "Very Good",  12082,
  "Premium",    13791,
  "Ideal",      21551
)
ggplot(data = demo) +
  geom_bar(mapping = aes(x = cut, y = freq), stat = "identity")

# 纵轴变为概率
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = ..prop.., group = 1))

# 柱状图加上颜色
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = cut)) # 使用fill

# fill的外生分类变量，会产生堆积柱状图
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity))

# 调整填充色的透明度***
ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) + 
  geom_bar(alpha = 1/5, position = "identity") # 使用alpha

# 只看占比(position='fill')
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill")

# 簇型柱状图(position='dodge')
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")


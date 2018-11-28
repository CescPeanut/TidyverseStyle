library(tidyverse) # 程序包：极乐净土

mpg # R自带汽车数据集

# ggplot散点图
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

# ggplot(data = <DATA>) + 
#   <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))

# ggplot散点图(分类)
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class))
# 尝试把color换成size,alpha,shape，有惊喜。（起到相同的区分效果）
# 把color放在aes外边，就是对全局调色

# ggplot散点图（分图）
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)

# ggplot散点图的拟合线图
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy), method = 'loess')

# 结合散点图+拟合曲线
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy), method = 'loess')

# 灵活写法:把aes放在ggplot()而不是geom_point()里，起到全局控制的作用
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth()

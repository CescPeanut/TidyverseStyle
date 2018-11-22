setwd('E://github/respository/Visualization')
# install.packages('recharts',repos ='http://yihui.name/xran')
library(recharts)

# 交互式散点图
ePoints(iris, ~Sepal.Length, ~Sepal.Width, series = ~Species)
# ePoints(df,~x,~y,series=~type)

###############################################################################
# recharts 包设计使用说明
# Yang Zhou
# 2016-11-07
# recharts 提供了百度开源可视化js框架ECharts的R语言接口，现提供的图形展示接口
# 包括：地图（eMap），柱状图（eBar），折线图（eLine）， 雷达图（eRadar），
# 散点图（ePoints），漏斗图（eFunnel）以及万恶的饼图（ePie）。 
# 同时计划对力导向图（eForce）， 时间序列散点图(ePoints_timeSeries)， 
# 矩阵树图(eTree)， 平行坐标图(eParallel) 和桑基图（eSankey）图逐一实现。
###############################################################################

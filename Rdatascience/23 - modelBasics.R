library(ggplot2)
library(modelr)
library(dplyr)

# ex1
ggplot(sim1, aes(x, y)) + 
  geom_point()

models <- tibble(
  a1 = runif(250, -20, 40),
  a2 = runif(250, -5, 5)
)

ggplot(sim1, aes(x, y)) + 
  geom_abline(aes(intercept = a1, slope = a2), data = models, alpha = 1/4) +
  geom_point() 

# ...
# ...


# Other model families
# Generalised linear models
? stats::glm()

# Generalised  additive models
? mgcv::gam()

# Trees
? rpart::rpart
? randomForest::randomForest()
? xgboost::xgboost

library(dplyr)
vignette("tibble")

# data.frame to tibble
iris <- as_tibble(iris)

# View tibble
iris

# Subsetting
df <- tibble(
  x = runif(5),
  y = rnorm(5)
)
# Different ways of subsetting lead to different results
x1 <- df$x
x2 <- df['x']
x3 <- df[['x']]
x4 <- df[,1]
x5 <- df[[1]]

# Riview:
# Filter to subsetting observations and Select to pick variables


library(dplyr)
# For loops
df <- tibble(
  a = rnorm(10),
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10)
)

# allocate space before loop
output <- vector("double", ncol(df))  # 1. output
for (i in seq_along(df)) {            # 2. sequence
  output[[i]] <- median(df[[i]])      # 3. body
}
output

# unknown output length
means <- c(0, 1, 2)
output <- double()
for (i in seq_along(means)) {
  n <- sample(100, 1)
  output <- c(output, rnorm(n, means[[i]]))
}
str(output)

# use a list instead for efficiency
out <- vector("list", length(means))
for (i in seq_along(means)) {
  n <- sample(100, 1)
  out[[i]] <- rnorm(n, means[[i]])
}
str(out)
str(unlist(out))
# or
purrr::flatten_dbl(out)

# patterns in other places
# to combine a string
# save the output in a vector
paste(output, collapse = "")
# to combine each row to a dataframe
# save the output in a list, then...
dplyr::bind_rows(output)


# the map functions
library(purrr)
map_dbl(df, mean)
map_dbl(df, sd)
# which is identical to
df %>% map_dbl(median)

# anonymous function*
models <- mtcars %>% 
  split(.$cyl) %>% 
  map(function(df) lm(mpg ~ wt, data = df))
# it is the same as
models <- mtcars %>% 
  split(.$cyl) %>% 
  map(~lm(mpg ~ wt, data = .))

# extract R-square in each cell
models %>% 
  map(summary) %>% 
  map_dbl(~.$r.squared)

# even more concise
models %>% 
  map(summary) %>% 
  map_dbl("r.squared")

# read more in R Data Science about map(), map2(), pmap()
# ex1
params <- tribble(
  ~mean, ~sd, ~n,
  5,     1,  1,
  10,     5,  3,
  -3,    10,  5
)
params %>% 
  pmap(rnorm)

# ex2
sim <- tribble(
  ~f,      ~params,
  "runif", list(min = -1, max = 1),
  "rnorm", list(sd = 5),
  "rpois", list(lambda = 10)
)
sim %>% 
  mutate(sim = invoke_map(f, params, n = 10))

# Predicate functions
# keep() & discard()
as_tibble(iris)
iris %>% 
  keep(is.factor) %>% 
  str()
iris %>% 
  discard(is.factor) %>% 
  str()

# some() & every()
x <- list(1:5, letters, list(10))
x %>% 
  some(is_character)
x %>% 
  every(is_character)

# detect() & detect_index()
x <- sample(10)
x %>% 
  detect(~ . > 5)
# ... 
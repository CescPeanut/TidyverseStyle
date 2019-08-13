# Scale figures
rescale01 <- function(x) {
  rng <- range(x, na.rm = TRUE)
  scale_x <- (x - rng[1]) / (rng[2] - rng[1])
  return(scale_x)
}

rescale01(c(0, 5, 10))

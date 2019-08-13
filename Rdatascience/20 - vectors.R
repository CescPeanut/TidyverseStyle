# creat a list
x <- list("a", "b", 1:10)
x[1]
x[[1]]
x[3][1]
x[[3]][1]


library(purrr)
?is_atomic()

x <- set_names(1:3, c("a", "b", "c"))
x[c("a", "c")]

# list subsetting
a <- list(a = 1:3, b = "a string", c = pi, d = list(-1, -5))
a$a
a[["a"]]

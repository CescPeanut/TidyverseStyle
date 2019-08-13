library(stringr)
library(dplyr)

# String length
str_length(c("a", "R for data science", NA))

# Combining strings
str_c("x", "y", "z")
str_c("x", "y", sep = ", ")
str_c("prefix-", c("a", "b", "c"), "-suffix")
str_c(c("x", "y", "z"), collapse = "")

# Subsetting strings
x <- c("Apple", "Banana", "Pear")
str_sub(x, 1, 3)
str_sub(x, -3, -1)

# Using subsetting technique to change part of strings
str_sub(x, 1, 1) <- str_to_lower(str_sub(x, 1, 1))


# Regular Expressionss
x <- c("apple", "banana", "pear")
str_detect(x, "e")

stringr::words
# How many common words start with t?
sum(str_detect(words, "^t"))
# What proportion of common words end with a vowel?
mean(str_detect(words, "[aeiou]$"))
# Find all words containing at least one vowel, and negate
no_vowels_1 <- !str_detect(words, "[aeiou]")
# Find all words consisting only of consonants (non-vowels)
no_vowels_2 <- str_detect(words, "^[^aeiou]+$")
identical(no_vowels_1, no_vowels_2)

# Two ways for subsetting strings
words[str_detect(words, "x$")]
str_subset(words, "x$")

# strings in a tibble
df <- tibble(
  word = words, 
  i = seq_along(word)
)
df %>% 
  filter(str_detect(word, "x$"))

# string count
x <- c("apple", "banana", "pear")
str_count(x, "a")

# On average, how many vowels per word?
mean(str_count(words, "[aeiou]"))


df %>% 
  mutate(
    vowels = str_count(word, "[aeiou]"),
    consonants = str_count(word, "[^aeiou]")
  )

# ...
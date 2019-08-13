library(ggplot2)

# Creating a ggplot
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class))
# 'color' has the same function as 'shape' or 'alpha'

# Check out if the 'color' order is out of 'aes'
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color = 'lightblue')

# Facets
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~class, nrow= 2)

# Bar Chart
# count the number of each type of the diamonds
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut))

# Use 'fill' order in bar chart
# self-fill
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = cut))
# classified-fill
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity))
# Use 'position' to make an adjustment
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")


# Point chart
# Add a random noise to spread data(to see the density of data)
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), position = "jitter")


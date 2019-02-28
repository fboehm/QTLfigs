# two-dimensional grid for pleiotropy testing

c1 <- c(rep(1:5, each = 5), 1:5)
c2 <- c(rep(1:5, times = 5), 1:5)
library(tidyverse)
library(ggalt) #contains geom_encircle
tibble(c1, c2) %>%
  ggplot() + geom_point(aes(x = c1, y = c2))
foo <- c(rep(2, 25), rep(1, 5))

tibble(c1, c2, foo = as.factor(foo)) %>%
  ggplot() + geom_encircle(aes(x = c1, 
                               y = c2, 
                               color = foo, 
                               #fill = foo, 
                               #alpha = 0.1
                               ), 
                           s_shape = 0, spread = 0.01, expand = 0.05
                           ) + 
  geom_point(aes(x = c1, y = c2, color = foo)) + 
  xlim(c(0, 6)) + ylim(c(0, 6)) + xlab("trait1 position") + 
  ylab("trait2 position") + 
  theme(legend.position = "none")

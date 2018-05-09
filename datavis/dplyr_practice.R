cat("\014")
rm(list = ls())
# exploring dplyr with michael levy's workshop
# http://www.michaellevy.name/blog/dplyr-data-manipulation-in-r-made-easy

###############################################################
install.packages("dplyr")
install.packages("babynames")
require(dplyr)
set.seed(1234)
rows <- 8
d <- data.frame(shape = sample(c("circle","square"), rows, replace = TRUE), 
                color = sample(c("red","blue"), rows, replace = TRUE),
                area = runif(rows, min = 1, max = 10))

# filter : choose rows

filter(d, shape == "circle")

# choose rows circle & area <2 or not circle (square) & area >3
filter(d, ifelse(shape == "circle", area <2, area>3))


# select: choose columns
select(d, shape, area)
select(d, shape:area)
select(d, -color)
select(d, contains("co"))
# the syntax is astoundingly simple


# arrange: ordering rows!
arrange(d, shape, color)
arrange(d, -area)

# mutate: make new columns (1:1)
mutate(d, new.color = sample(rainbow(8)), 
          perimeter = ifelse(shape == "square", 4*area^0.5, 2&(pi*area)^0.5),
          side.length = ifelse(shape == "square", perimeter/4, NA))

# summarize() + group_by() -- make new columns (N:1)

d.by.col <- group_by(d,color)
d.by.col

summarize(d.by.col, tot.area = sum(area))

# indent is important
d %>%
  group_by(shape, color) %>%
  summarize(max.area = max(area))


library(babynames)
d<- tbl_df(babynames)

d %>%
  filter(year >= 1980 & year < 1990) %>%
  group_by(sex,name) %>%
  summarize(count = sum(n)) %>%
  mutate(position = rank(-count)) %>%
  filter(position <= 10) %>%
  arrange(sex,position)



# official vignette: http://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html

install.packages("nycflights13")
library(nycflights13)

head(flights)

filter(flights, month ==1)
slice(flights, 1:10)



mutate(flights, gain = arr_delay - dep_delay)

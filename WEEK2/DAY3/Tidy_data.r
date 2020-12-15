# https://r4ds.had.co.nz/tidy-data.html
library(tidyverse)

# which of these is tidy data

table1  # A tibble: 6 x 4

table2   # A tibble: 12 x 4

table3   # A tibble: 6 x 3

# Spread across two tibbles

table4a  # A tibble: 3 x 3 # cases

table4b    # A tibble: 3 x 3 # population


# tidying when a column names are values of variables

table4a

tidy4a <- table4a %>% 
  pivot_longer(c(`1999`, `2000`), names_to = "year", values_to = "cases")
tidy4a

tidy4b <- table4b %>% 
  pivot_longer(c(`1999`, `2000`), names_to = "year", values_to = "population")
tidy4b

left_join(tidy4a, tidy4b)


# tidying when observations are accross multiple rows

table2

table2 %>%
  pivot_wider(names_from = type, values_from = count)


################12.3.3 Exercises#####################

#1. Why are pivot_longer() and pivot_wider() not perfectly symmetrical?Carefully consider the following example:

#ٍ############SOLUTION#############

#pivot_longer() stacks multiple columns which may have had multiple data types into a single column with a single data type.
#The function pivot_wider() creates column names from values in column. These column names will always be treated as character values by pivot_longer() 
#so if the original variable used to create the column names did not have a character data type, then the round-trip will not reproduce the same dataset.

stocks <- tibble(
  year   = c(2015, 2015, 2016, 2016),
  half  = c(   1,    2,     1,    2),
  return = c(1.88, 0.59, 0.92, 0.17)
)

stocks %>% 
  pivot_wider(names_from = year, values_from = return) %>% 
  pivot_longer(`2015`:`2016`, names_to = "year", values_to = "return")


glimpse(stocks)

stocks %>%
  pivot_wider(names_from = year, values_from = return) 

stocks %>%
  pivot_wider(names_from = year, values_from = return)%>%
  pivot_longer(`2015`:`2016`, names_to = "year", values_to = "return")

stocks %>%
  pivot_wider(names_from = year, values_from = return)%>%
  pivot_longer(`2015`:`2016`, names_to = "year", values_to = "return",
               names_ptype = list(year = double()))
#> Error: Can't convert <character> to <double>.

stocks %>%
  pivot_wider(names_from = year, values_from = return)%>%
  pivot_longer(`2015`:`2016`, names_to = "year", values_to = "return",
               names_transform = list(year = as.numeric))
#####################################################################

#2.Why does this code fail?



table4a %>% 
  pivot_longer(c(1999, 2000), names_to = "year", values_to = "cases")

#The code fails because the column names 1999 and 2000 are not non-syntactic variable names.

# CORRECTION
table4a %>% 
  pivot_longer(c(`1999`, `2000`), names_to = "year", values_to = "cases")

########################################################################
#3.What would happen if you widen this table? Why? How could you add a new column to uniquely identify each value?

#Widening this data frame using pivot_wider() produces columns that are lists of numeric vectors because the name and key columns do not uniquely identify rows. 
#In particular, there are two rows with values for the age of “Phillip Woods”.
people <- tribble(
  ~name,             ~names,  ~values,
  #-----------------|--------|------
  "Phillip Woods",   "age",       45,
  "Phillip Woods",   "height",   186,
  "Phillip Woods",   "age",       50,
  "Jessica Cordero", "age",       37,
  "Jessica Cordero", "height",   156
)

glimpse(people)
pivot_wider(people, names_from="name", values_from = "value")



people2 <- people %>%
  group_by(name, key) %>%
  mutate(obs = row_number())
people2

pivot_wider(people2, names_from="name", values_from = "value")

# tidying when multiple variables in the same row 

table3

table3 %>%
  separate(rate, into = c("cases", "population"), sep = "/")




# Compute rate per 10,000
table1 %>% 
  mutate(rate = cases / population * 10000)  # A tibble: 6 x 5

# Compute cases per year
table1 %>% 
  count(year, wt = cases)   # A tibble: 2 x 2

# Visualise changes over time
library(ggplot2)
ggplot(table1, aes(year, cases)) + 
  geom_line(aes(group = country), colour = "grey50") + 
  geom_point(aes(colour = country))



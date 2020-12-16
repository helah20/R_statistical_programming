# ######################Strings#########################
library(tidyverse)
string1 <- "This is a string"
string2 <- 'If I want to include a "quote" inside a string, I use single quotes'
double_quote <- "\"" # or '"'
single_quote <- '\'' # or "'"


x <- c("\"", "\\")
x
#> [1] "\"" "\\"
writeLines(x)
#> "
#> \

x <- "\u00b5"
x
#> [1] "µ"

c("one", "two", "three")
#> [1] "one"   "two"   "three"

#   String length

str_length(c("a", "R for data science", NA))
#> [1]  1 18 NA

##Combining strings
str_c("x", "y")
#> [1] "xy"
str_c("x", "y", "z")
#> [1] "xyz"


str_c("x", "y", sep = ", ")
#> [1] "x, y"

x <- c("abc", NA)
str_c("|-", x, "-|")
#> [1] "|-abc-|" NA
str_c("|-", str_replace_na(x), "-|")
#> [1] "|-abc-|" "|-NA-|"

str_c("prefix-", c("a", "b", "c"), "-suffix")
#> [1] "prefix-a-suffix" "prefix-b-suffix" "prefix-c-suffix"


name <- "Hadley"
time_of_day <- "morning"
birthday <- FALSE

str_c(
  "Good ", time_of_day, " ", name,
  if (birthday) " and HAPPY BIRTHDAY",
  "."
)
#> [1] "Good morning Hadley."

str_c(c("x", "y", "z"), collapse = ", ")
#> [1] "x, y, z"

##########Subsetting strings#################

x <- c("Apple", "Banana", "Pear")

str_sub(x, 1, 3)
#> [1] "App" "Ban" "Pea"


# negative numbers count backwards from end
str_sub(x, -3, -1)
#> [1] "ple" "ana" "ear"

str_sub("a", 1, 5)
#> [1] "a"

str_sub(x, 1, 1) <- str_to_lower(str_sub(x, 1, 1))
x
#> [1] "apple"  "banana" "pear"

# Turkish has two i's: with and without a dot, and it
# has a different rule for capitalising them:
str_to_upper(c("i", "ı"))
#> [1] "I" "I"
str_to_upper(c("i", "ı"), locale = "tr")
#> [1] "İ" "I"



x <- c("apple", "eggplant", "banana")

str_sort(x, locale = "en")  # English
#> [1] "apple"    "banana"   "eggplant"

str_sort(x, locale = "haw") # Hawaiian
#> [1] "apple"    "eggplant" "banana"

################## Basic matches#####################

# needs to install.packages("htmlwidgets")

x <- c("apple", "banana", "pear")
str_view(x, "an")

str_view(x, ".a.")

# To create the regular expression, we need \\
dot <- "\\."
 cat(dot)
# But the expression itself only contains one:
writeLines(dot)
#> \.

# And this tells R to look for an explicit .
str_view(c("abc", "a.c", "bef"), "a\\.c")



x <- "a\\b"
writeLines(x)
#> a\b

str_view(x, "\\\\")


###################Anchors#########################

#^ to match the start of the string.
#$ to match the end of the string.

x <- c("apple", "banana", "pear")
str_view(x, "^a")


str_view(x, "a$")

x <- c("apple pie", "apple", "apple cake")
str_view(x, "apple")


str_view(x, "^apple$")


################Character classes and alternatives##################
#\d: matches any digit.
#\s: matches any whitespace (e.g. space, tab, newline).
#[abc]: matches a, b, or c.
#[^abc]: matches anything except a, b, or c.



# Look for a literal character that normally has special meaning in a regex
str_view(c("abc", "a.c", "a*c", "a c"), "a[.]c")


str_view(c("abc", "a.c", "a*c", "a c"), ".[*]c")

str_view(c("abc", "a.c", "a*c", "a c"), "a[ ]")

str_view(c("grey", "gray"), "gr(e|a)y")

##################Repetition##############

x <- "1888 is the longest year in Roman numerals: MDCCCLXXXVIII"
str_view(x, "CC?")


str_view(x, "CC+")

str_view(x, 'C[LX]+')

str_view(x, 'C[LX]+')

str_view(x, "C{2}")

str_view(x, "C{2,}")

str_view(x, "C{2,3}")

str_view(x, 'C{2,3}?')

str_view(x, 'C[LX]+?')

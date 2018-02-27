# steamspyR

The goal of steamspyR is to download and parse various chunks of API data from ... You GUESSED IT, [Steam Spy](https://steamspy.com/).

As with all things API based, there is a limit on how quickly they want you to ping the website. Currently, they request no more than 4 times / second, so please don't be a jerk and abuse the API.

## Installation

You can install the development version of steamspyR with:

``` r
if (!requireNamespace("devtools", quietly = TRUE)) {
  install.packages("devtools")
}
devtools::install_github("thomas-keller/steamspyR")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(steamspyR)
scidf <- genre_tag("Sci-fi")
qplot(price,players_forever,data=scidf,geom='point') + cowplot::theme_cowplot()
```


This will produce a nice pretty ggplot graph formatted using [cowplot](https://cran.r-project.org/web/packages/cowplot/vignettes/introduction.html) with little effort.


![meaningless plot](https://github.com/thomas-keller/steamspyR/blob/master/steamspy_ex.png)

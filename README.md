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

This is a basic example which shows you look at one type of problem, what is the relationship beteween playerbase and the price of games? We will stratify it by the new bins that steamspy returns on the estimate game copies:

``` r
library(steamspyR)
library(forcats)
df=genre_games("Action")

df$owners=readr::parse_factor(df$owners,rev(unique(df$owners)))

library(ggplot)

library(cowplot)
ggplot(aes(price,median_2weeks),data=df)+facet_wrap(~owners)+geom_point()
```


This will produce a nice pretty ggplot graph formatted using [cowplot](https://cran.r-project.org/web/packages/cowplot/vignettes/introduction.html).


![meaningless plot](https://github.com/thomas-keller/steamspyR/blob/master/steamspy_ex.png)



## UPDATE 04/30/18 !!!

[About a month ago](https://steamed.kotaku.com/latest-steam-update-is-bad-news-for-steam-spy-1825163900) Steam flipped a switch changing most user profile information private by default, thereby rendering the usual method SteamSpy uses to approximate numbers ineffective. However, in the last couple days the developer Sergey Galyonkin released a [blog post](https://galyonk.in/whats-going-on-with-steam-spy-deed5d699233) about a machine-learning method he was using to get to most of the same numbers. The initial results sound promising, although I guess there's understandably a bit more noise on the estimates. So, steamspy shambles on, with even the api mostly intact. It's changed slightly since I last looked at it a couple months ago, so I updated the package to reflect that.

(Tags are out for the moment, but additional info on the initial price and current discount are available)















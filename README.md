
<!-- README.md is generated from README.Rmd. Please edit that file -->

# gtakeout

<!-- badges: start -->

[![R-CMD-check](https://github.com/jrosell/gtakeout/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/jrosell/gtakeout/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of gtakeout is to extract data from Google Takeout.

## Installation

You can install the development version of gtakeout like so:

``` r
install.packages("gtakeout", repos = "https://jrosell.r-universe.dev")
```

## Examples

### Google Business Profiles

This is a basic example which shows you how to extract the reviews form
a Takedown zip file.

``` r
library(gtakeout)

# devtools::load_all()

takeout_zipfile <- fs::dir_ls(here::here("data", "input"), glob = "*.zip") |>
  head(1)

output_path <- fs::dir_create(here::here("data", "output"))

gtakeout_reviews(takeout_zipfile, exdir = output_path)
#> # A tibble: 1 × 9
#>   account         location   reviewer star_raw comment created updated review_id
#>   <chr>           <chr>      <chr>    <chr>    <chr>   <chr>   <chr>   <chr>    
#> 1 account-example location-… Example… FIVE     exampl… 2025-0… 2025-0… accounts…
#> # ℹ 1 more variable: listing_name <chr>
```

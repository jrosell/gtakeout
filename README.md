
<!-- README.md is generated from README.Rmd. Please edit that file -->

# gtakeout

<!-- badges: start -->

<!-- badges: end -->

The goal of gtakeout is to extract data from Google Takeout.

## Installation

You can install the development version of gtakeout like so:

``` r
install.packages("gtakeout", repos = "https://jrosell.r-universe.dev")
```

## Examples

### Reviews from Google Business Profiles

This is a basic example which shows you how to get the reviews from your Google Business Profiles in Takedown extracted files.

``` r
library(gtakeout)

# devtools::load_all()

takeout_zipfile <- fs::dir_ls(here::here("data", "input"), glob = "*.zip") |>
  head(1)

output_path <- fs::dir_create(here::here("data", "output"))

gtakeout_reviews(takeout_zipfile, output_path)
#> # A tibble: 58 × 9
#>    account          location reviewer star_raw comment created updated review_id
#>    <chr>            <chr>    <chr>    <chr>    <chr>   <chr>   <chr>   <chr>    
#>  1 account-1169904… locatio… Xavi Va… ONE       <NA>   2024-1… 2024-1… accounts…
#>  2 account-1169904… locatio… David P… FIVE      <NA>   2024-0… 2024-0… accounts…
#>  3 account-1169904… locatio… Amparo … FIVE      <NA>   2023-1… 2023-1… accounts…
#>  4 account-1169904… locatio… REAL LI… FIVE     "👍"    2023-0… 2023-0… accounts…
#>  5 account-1169904… locatio… Josep S… FIVE      <NA>   2023-0… 2023-0… accounts…
#>  6 account-1169904… locatio… El meft… FIVE      <NA>   2023-0… 2023-0… accounts…
#>  7 account-1169904… locatio… Felipe … TWO      "(Tran… 2023-0… 2023-0… accounts…
#>  8 account-1169904… locatio… javier … FIVE      <NA>   2022-0… 2022-0… accounts…
#>  9 account-1169904… locatio… juan an… FIVE      <NA>   2021-1… 2021-1… accounts…
#> 10 account-1169904… locatio… Silvio   FIVE     "(Tran… 2021-0… 2021-0… accounts…
#> # ℹ 48 more rows
#> # ℹ 1 more variable: listing_name <chr>
```

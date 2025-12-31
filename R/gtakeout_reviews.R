#' @export
gtakeout_reviews <- \(zipfile, exdir = here::here("data")) {
  unzip_reviews(zipfile, exdir)

  additionalData_files <-
    zipfile |>
    zip_list() |>
    filter(str_detect(filename, "Google Business Profile")) |>
    filter(str_detect(filename, "additionalData.json")) |>
    pull(filename)

  additionalData_df <- additionalData_files |>
    map_dfr(\(x) {
      extract_listing_name(x, exdir = here::here("data", "output"))
    })

  reviews_files <-
    zipfile |>
    zip_list() |>
    filter(str_detect(filename, "Google Business Profile")) |>
    filter(str_detect(filename, "reviews.json")) |>
    pull(filename)

  reviews_df <- reviews_files |>
    map_dfr(\(x) {
      extract_reviews(x, exdir = here::here("data", "output"))
    })

  reviews_full <- reviews_df |>
    left_join(additionalData_df, by = c("account", "location"))

  reviews_full
}


#' @noRd
extract_listing_name <- function(path, exdir = here::here("data")) {
  if (!is.null(exdir)) {
    path <- here::here(exdir, path)
  }

  data <- read_json(path, simplifyVector = FALSE)

  listing_name <- data$attributes |>
    keep(~ .x$id$attributeType == "LISTING_NAME") |>
    pluck(
      1,
      "values",
      1,
      "datum",
      "listingName",
      "text",
      .default = NA_character_
    )

  tibble(
    account = str_extract(path, "account-[^/]+"),
    location = str_extract(path, "location-[^/]+"),
    listing_name = listing_name
  )
}


#' @noRd
extract_reviews <- function(path, exdir = here::here("data")) {
  if (!is.null(exdir)) {
    path <- here::here(exdir, path)
  }

  data <- read_json(path, simplifyVector = FALSE)

  reviews <- data$reviews
  if (length(reviews) == 0) {
    return(tibble())
  }

  map_dfr(reviews, function(r) {
    tibble(
      account = str_extract(path, "account-[^/]+"),
      location = str_extract(path, "location-[^/]+"),
      reviewer = r$reviewer$displayName %||% NA_character_,
      star_raw = r$starRating %||% NA_character_,
      comment = r$comment %||% NA_character_,
      created = r$createTime %||% NA_character_,
      updated = r$updateTime %||% NA_character_,
      review_id = r$name %||% NA_character_
    )
  })
}

#' @noRd
unzip_reviews <- \(zipfile, exdir = here::here("data")) {
  if (is.null(zipfile) || !fs::file_exists(zipfile)) {
    rlang::abort("zipfile must be a existing file.")
  }
  if (is.null(exdir) || !fs::dir_exists(exdir)) {
    rlang::abort("exdir must be a existing folder.")
  }

  additionalData_files <-
    zipfile |>
    zip_list() |>
    filter(str_detect(filename, "Google Business Profile")) |>
    filter(str_detect(filename, "additionalData.json")) |>
    pull(filename)

  reviews_files <-
    zipfile |>
    zip_list() |>
    filter(str_detect(filename, "Google Business Profile")) |>
    filter(str_detect(filename, "reviews.json")) |>
    pull(filename)

  files <- c(additionalData_files, reviews_files)
  unzip(
    zipfile,
    files = c(additionalData_files, reviews_files),
    overwrite = TRUE,
    exdir = exdir
  )
  files
}

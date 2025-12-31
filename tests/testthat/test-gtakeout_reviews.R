test_that("gtakeout_reviews works", {
  zip_path <- system.file(
    "extdata",
    "takeout-example.zip",
    package = "gtakeout"
  )
  df <- gtakeout_reviews(zip_path, exdir = tempdir())
  expect_equal(df$listing_name, "Example NAME")
})

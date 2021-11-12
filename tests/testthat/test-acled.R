readRenviron(".Renv")

test_that("credential checks work", {
  skip_on_cran()
  expect_error(acled.api(email.address = "",
                         access_key = "",
                         start.date = "2020-11-01",
                         end.date = "2020-11-31"))
  expect_error(acled.api(email.address = "email@address.com",
                         access.key = "",
                         start.date = "2020-11-01",
                         end.date = "2020-11-31"),
               regexp = "ACLED requires an access key")
  expect_error(acled.api(email.address = "",
                         access.key = "access_key",
                         start.date = "2020-11-01",
                         end.date = "2020-11-31"),
               regexp = "ACLED requires an email address")
})

test_that("check that country validation works", {
  skip_on_cran()
  expect_error(acled.api(email.address = Sys.getenv("EMAIL_ADDRESS"),
                         access.key = Sys.getenv("ACCESS_KEY"),
                         country = 1),
               regexp = "If you wish to specify country names")
})

test_that("check that region validation works", {
  skip_on_cran()
  expect_error(acled.api(email.address = Sys.getenv("EMAIL_ADDRESS"),
                         access.key = Sys.getenv("ACCESS_KEY"),
                         region = TRUE),
               regexp = "If you wish to specify regions")
  expect_message(acled.api(email.address = Sys.getenv("EMAIL_ADDRESS"),
                           access.key = Sys.getenv("ACCESS_KEY"),
                           region = "Central America",
                           start.date = "2019-01-01",
                           end.date = "2019-01-31"),
                 regexp = "Your ACLED data request was successful")
})

test_that("check that date validation works", {
  skip_on_cran()
  expect_error(acled.api(email.address = Sys.getenv("EMAIL_ADDRESS"),
                         access.key = Sys.getenv("ACCESS_KEY"),
                         start.date = "1999-01-01"),
               regexp = "You need to supply either no start date and no end date")
  expect_error(acled.api(email.address = Sys.getenv("EMAIL_ADDRESS"),
                         access.key = Sys.getenv("ACCESS_KEY"),
                         start.date = "1999-12-31",
                         end.date = "1999-01-01"),
               regexp = "The start date cannot be larger than the end date.")
})

test_that("check that all.variables validation works", {
  skip_on_cran()
  expect_error(acled.api(email.address = Sys.getenv("EMAIL_ADDRESS"),
                         access.key = Sys.getenv("ACCESS_KEY"),
                         all.variables = 1),
               regexp = "The argument 'all.variables' requires a logical value")
})

test_that("check that dyadic validation works", {
  skip_on_cran()
  expect_error(acled.api(email.address = Sys.getenv("EMAIL_ADDRESS"),
                         access.key = Sys.getenv("ACCESS_KEY"),
                         dyadic = 1),
               regexp = "The argument 'dyadic' requires a logical value")
})

test_that("unauthorized credentials return 403", {
  skip_on_cran()
  expect_message(acled.api(email.address = "email@address.com",
                           access.key = "access_key"),
                 regexp = "GET request wasn't successful. The API returned status 403")
})

test_that("API extraction works", {
  skip_on_cran()
  expect_message(acled.api(email.address = Sys.getenv("EMAIL_ADDRESS"),
                           access.key = Sys.getenv("ACCESS_KEY"),
                           start.date = "2007-04-01",
                           end.date = "2007-04-07",
                           region = c(1,2)),
                 regexp = "Events were retrieved for the period starting 2007-04-01 until 2007-04-07")
  expect_gt(nrow(acled.api(email.address = Sys.getenv("EMAIL_ADDRESS"),
                           access.key = Sys.getenv("ACCESS_KEY"),
                           start.date = "2007-04-01",
                           end.date = "2007-04-07")),
            expected = 1)
})

test_that("region specification works", {
  skip_on_cran()
  expect_equal(length(unique(acled.api(email.address = Sys.getenv("EMAIL_ADDRESS"),
                                       access.key = Sys.getenv("ACCESS_KEY"),
                                       start.date = "2007-04-01",
                                       end.date = "2007-04-07",
                                       region = c(1))$region)),
               expected = 1)
  expect_equal(unique(acled.api(email.address = Sys.getenv("EMAIL_ADDRESS"),
                                access.key = Sys.getenv("ACCESS_KEY"),
                                start.date = "2021-01-01",
                                end.date = "2021-02-01",
                                region = c(1))$region),
               expected = "Western Africa")
  expect_equal(unique(acled.api(email.address = Sys.getenv("EMAIL_ADDRESS"),
                                access.key = Sys.getenv("ACCESS_KEY"),
                                start.date = "2021-01-01",
                                end.date = "2021-02-01",
                                region = c(12))$region),
               expected = "Europe")
  expect_equal(unique(acled.api(email.address = Sys.getenv("EMAIL_ADDRESS"),
                                access.key = Sys.getenv("ACCESS_KEY"),
                                start.date = "2021-01-01",
                                end.date = "2021-02-01",
                                region = c(18))$region),
               expected = "North America")
})

test_that("all.variables works", {
  skip_on_cran()
  expect_equal(ncol(acled.api(email.address = Sys.getenv("EMAIL_ADDRESS"),
                              access.key = Sys.getenv("ACCESS_KEY"),
                              start.date = "2007-04-01",
                              end.date = "2007-04-8",
                              region = 1,
                              all.variables = TRUE)),
               expected = 31)
})

test_that("check that data outside coverage return empty", {
  skip_on_cran()
  expect_message(acled.api(email.address = Sys.getenv("EMAIL_ADDRESS"),
                           access.key = Sys.getenv("ACCESS_KEY"),
                           country = "turkey",
                           start.date = "1999-01-01",
                           end.date = "1999-12-31"),
                 regexp = "No data found for this area and time period.")
})

test_that("check add.variables works", {
  skip_on_cran()
  expect_equal(ncol(acled.api(email.address = Sys.getenv("EMAIL_ADDRESS"),
                              access.key = Sys.getenv("ACCESS_KEY"),
                              start.date = "2007-04-01",
                              end.date = "2007-04-8",
                              add.variables = "geo_precision")),
               15)
  expect_message(acled.api(email.address = Sys.getenv("EMAIL_ADDRESS"),
                           access.key = Sys.getenv("ACCESS_KEY"),
                           start.date = "2007-04-01",
                           end.date = "2007-04-08",
                           add.variables = "actor3"),
                 regexp = "Unknown column 'actor3' in 'field list'")
})

test_that("check URL encoding works for country", {
  skip_on_cran()
  expect_message(acled.api(email.address = Sys.getenv("EMAIL_ADDRESS"),
                           access.key = Sys.getenv("ACCESS_KEY"),
                           country = "Burkina Faso",
                           start.date = "2007-04-01",
                           end.date = "2007-12-31"),
                 regexp = "Your ACLED data request was successful.")
})

test_that("other.query works", {
  skip_on_cran()
  expect_lt(nrow(acled.api(email.address = Sys.getenv("EMAIL_ADDRESS"),
                           access.key = Sys.getenv("ACCESS_KEY"),
                           start.date = "2007-04-01",
                           end.date = "2007-05-31",
                           other.query = "interaction=17")),
            70) # to account for potential increases in returned rows w/ ACLED updates
})

test_that("get.api.regions works", {
  skip_on_cran()
  expect_equal(length(get.api.regions()),
               expected = 2)
})



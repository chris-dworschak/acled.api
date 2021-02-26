test_that("inter1 and inter2 work", {
  expect_length(unique(acled.api(email.address = Sys.getenv("EMAIL_ADDRESS"),
                                 access.key = Sys.getenv("ACCESS_KEY"),
                                 start.date = "2020-11-01",
                                 end.date = "2020-11-31",
                                 inter1 = c(2, 3),
                                 inter2 = 8)[, "interaction"]),
                n=2)
  expect_length(unique(acled.api(email.address = Sys.getenv("EMAIL_ADDRESS"),
                                 access.key = Sys.getenv("ACCESS_KEY"),
                                 start.date = "2020-11-01",
                                 end.date = "2020-11-31",
                                 inter1 = 1,
                                 inter2 = c(6, 7))[, "interaction"]),
                n=2)
  })

test_that("interaction works", {
  expect_length(unique(acled.api(email.address = Sys.getenv("EMAIL_ADDRESS"),
                                 access.key = Sys.getenv("ACCESS_KEY"),
                                 start.date = "2020-11-01",
                                 end.date = "2020-11-31",
                                 interaction = c(18, 28, 38))[, "interaction"]),
                n = 3)
})

test_that("inter* validation works", {
  expect_error(acled.api(email.address = Sys.getenv("EMAIL_ADDRESS"),
                         access.key = Sys.getenv("ACCESS_KEY"),
                         start.date = "2020-11-01",
                         end.date = "2020-11-31",
                         inter1 = 2,
                         interaction = 18),
               regexp = "All actor 1 type codes must be present in both the 'inter1' and 'interaction' arguments")
  expect_error(acled.api(email.address = Sys.getenv("EMAIL_ADDRESS"),
                         access.key = Sys.getenv("ACCESS_KEY"),
                         start.date = "2020-11-01",
                         end.date = "2020-11-31",
                         inter2 = 2,
                         interaction = 18),
               regexp = "All actor 2 type codes must be present in both the 'inter2' and 'interaction' arguments")
  expect_error(acled.api(email.address = Sys.getenv("EMAIL_ADDRESS"),
                         access.key = Sys.getenv("ACCESS_KEY"),
                         start.date = "2020-11-01",
                         end.date = "2020-11-31",
                         inter1 = "not an inter code"),
               regexp = "The argument 'inter1' requires a numeric value")
  expect_error(acled.api(email.address = Sys.getenv("EMAIL_ADDRESS"),
                         access.key = Sys.getenv("ACCESS_KEY"),
                         start.date = "2020-11-01",
                         end.date = "2020-11-31",
                         inter2 = "not an inter code"),
               regexp = "The argument 'inter2' requires a numeric value")
  expect_error(acled.api(email.address = Sys.getenv("EMAIL_ADDRESS"),
                         access.key = Sys.getenv("ACCESS_KEY"),
                         start.date = "2020-11-01",
                         end.date = "2020-11-31",
                         interaction = "not an inter code"),
               regexp = "The 'interaction' argument requires a numeric value")
})

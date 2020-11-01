
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Automated Retrieval of ACLED Conflict Event Data

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version-last-release/acled.api)](https://CRAN.R-project.org/package=acled.api)
[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://www.tidyverse.org/lifecycle/#stable)
[![Travis build
status](https://travis-ci.com/chris-dworschak/acled.api.svg?branch=master)](https://travis-ci.com/chris-dworschak/acled.api)
[![CRANlogs](http://cranlogs.r-pkg.org/badges/grand-total/acled.api)](https://CRAN.R-project.org/package=acled.api)
<!-- badges: end -->

This small package provides functionality to access and manage the
application programming interface (API) of the [Armed Conflict Location
& Event Data Project (ACLED)](https://acleddata.com/). The function
`acled.api()` makes it easy to retrieve a user-defined sample (or all of
the available data) of ACLED, enabling a seamless integration of regular
data updates into the research work flow.

When using this package, you acknowledge that you have read ACLED’s
terms and conditions of use, and that you agree with their attribution
requirements.

## Installation

You can install the latest release version of acled.api from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("acled.api")
```

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("chris-dworschak/acled.api") # downloads and installs the package
```

## Example

Using `acled.api` is straight forward. To download data on, for example,
all ACLED conflict events in Europe and Central America that happened
between June 2019 and July 2020, you can supply:

``` r
library(acled.api) # loads the package
#> 
#> By using this package, you acknowledge that you have read ACLED's terms and
#> conditions. The data must be cited as per ACLED attribution requirements. To
#> download ACLED data, you require an ACLED access key. You can request your key
#> by freely registering with ACLED on https://developer.acleddata.com/.
#> The package may be cited as:
#> Dworschak, Christoph. 2020. "Acled.api: Automated Retrieval of ACLED Conflict
#> Event Data." R package. CRAN version 1.0.8.
#> For the development version of this package, visit <https://github.com/chris-dworschak/acled.api/>

my.data.frame <- acled.api( # stores an ACLED sample in object my.data.frame
  email.address = Sys.getenv("EMAIL_ADDRESS"),
  access.key = Sys.getenv("ACCESS_KEY"),
  region = c("Southern Asia", "Central America"), 
  start.date = "2019-06-01", 
  end.date = "2020-07-31")
#> Your ACLED data request was successful. 
#> Events were retrieved for the period starting 2019-06-01 until 2020-07-31.

my.data.frame[1:3,] # returns the first three observations of the ACLED sample
#>                      region     country year event_date
#> 1 Caucasus and Central Asia  Azerbaijan 2020 2020-07-31
#> 2 Caucasus and Central Asia Afghanistan 2020 2020-07-31
#> 3 Caucasus and Central Asia  Azerbaijan 2020 2020-07-31
#>                              source   admin1 admin2 admin3          location
#> 1 Ministry of Defence of Azerbaijan Jabrayil               Chodjuk-Mardjanli
#> 2  Afghan Islamic Press News Agency  Helmand Sangin                   Sangin
#> 3 Ministry of Defence of Azerbaijan    Tovuz                          Aghdam
#>                   event_type sub_event_type interaction fatalities
#> 1                    Battles    Armed clash          11          0
#> 2 Violence against civilians         Attack          37          1
#> 3                    Battles    Armed clash          18          0
```

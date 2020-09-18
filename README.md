
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Automated Retrieval of ACLED Conflict Event Data

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/acled.api)](https://CRAN.R-project.org/package=acled.api)
[![Travis build
status](https://travis-ci.com/chris-dworschak/acled.api.svg?branch=master)](https://travis-ci.com/chris-dworschak/acled.api)
[![Lifecycle:
maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
<!-- badges: end -->

This small package provides functionality to access and manage the
application programming interface (API) of the [Armed Conflict Location
& Event Data Project (ACLED)](https://acleddata.com/). The package
`acleda.api` makes it easy to retrieve a user-defined sample (or all of
the available data) of ACLED, enabling a seamless integration of regular
data updates into the research work flow.

Important: When using this package, you acknowledge that you have read
ACLED’s terms and conditions of use, and that you agree with their
attribution requirements.

## Installation

You can install the released version of acled.api from
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
#> By using this package, you acknowledge that you have read ACLED's terms
#> and conditions. The data must be cited as per ACLED attribution requirements.
#> The package may be cited as:
#> Dworschak, Christoph. 2020. "Acled.api: Automated Retrieval of ACLED Conflict
#> Event Data." R package version 1.0.2. <https://github.com/chris-dworschak/acled.api/>

my.data.frame <- acled.api( # stores an ACLED sample in object my.data.frame
  regions = c("Europe", "Central America"), 
  start.date = "2019-06-01", 
  end.date = "2020-07-31")
#> Your ACLED data request was successful. Events were retrieved for the period starting 2019-06-01 until 2020-07-31.

head(my.data.frame) # returns the first five observations of the ACLED sample
#>        region country year event_date                            source
#> 1 Middle East  Israel 2020 2020-07-31               Black Flag Movement
#> 2 Middle East  Israel 2020 2020-07-31               Black Flag Movement
#> 3 Middle East  Israel 2020 2020-07-31               Black Flag Movement
#> 4 Middle East  Turkey 2020 2020-07-31 Human Rights Foundation of Turkey
#> 5 Middle East  Israel 2020 2020-07-31               Black Flag Movement
#> 6 Middle East  Israel 2020 2020-07-31               Black Flag Movement
#>     admin1      admin2 admin3                         location event_type
#> 1 Tel Aviv    Tel Aviv                       Mehlaf Alluf Sade   Protests
#> 2 HaMerkaz Petah Tikva                                    Enat   Protests
#> 3 HaMerkaz       Ramla        Ben Gurion International Airport   Protests
#> 4   Ankara     Cankaya                                 Cankaya   Protests
#> 5 HaMerkaz     Rehovot                           Rishon LeZion   Protests
#> 6 HaMerkaz     Rehovot                                 Rehovot   Protests
#>              sub_event_type interaction fatalities
#> 1          Peaceful protest          60          0
#> 2          Peaceful protest          60          0
#> 3          Peaceful protest          60          0
#> 4 Protest with intervention          16          0
#> 5          Peaceful protest          60          0
#> 6          Peaceful protest          60          0
```

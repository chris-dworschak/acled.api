
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Automated Retrieval of ACLED Conflict Event Data

<!-- badges: start -->

[![Travis build
status](https://travis-ci.com/chris-dworschak/acled.api.svg?branch=master)](https://travis-ci.com/chris-dworschak/acled.api)
<!-- badges: end -->

This small package makes it easy to automatically retrieve a
user-defined sample or all available data of ACLED: the package provides
functionality to access and manage the application programming interface
(API) of the Armed Conflict Location & Event Data Project (ACLED) at
<https://acleddata.com/>.

When using this package, you acknowledge that you have read ACLED’s
terms and conditions of use, and that you agree with their attribution
requirements.

## Installation

You can install the released version of acled.api from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("acled.api")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("chris-dworschak/acled.api") # downloads and installs the package
```

## Example

Using acled.api is straight forward. To download data on, for example,
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
  regions = c(12,14), 
  start.date = "2019-06-01", 
  end.date = "2020-07-31")
#> Your ACLED data request was successful. Events were retrieved for the period starting 2019-06-01 until 2020-07-31.

head(my.data.frame) # returns the first five observations of the ACLED sample
#>            region country year event_date                 source       admin1
#> 1          Europe Ukraine 2020 2020-07-31         National Corps    Kiev City
#> 2          Europe Ukraine 2020 2020-07-31 Vholos; National Corps         Lviv
#> 3          Europe Ukraine 2020 2020-07-31       OSCE SMM-Ukraine      Donetsk
#> 4          Europe Ukraine 2020 2020-07-31       OSCE SMM-Ukraine      Luhansk
#> 5 Central America  Mexico 2020 2020-07-31              La Verdad Quintana Roo
#> 6          Europe Ukraine 2020 2020-07-31       OSCE SMM-Ukraine      Donetsk
#>              admin2 admin3          location                 event_type
#> 1              Kiev        Kiev-Solomyanskyi                   Protests
#> 2 Lviv Municipality                     Lviv                   Protests
#> 3       Telmanivsky              Zaporozhets Explosions/Remote violence
#> 4      Novoaidarsky                Sokilnyky Explosions/Remote violence
#> 5   Othon P. Blanco                 Chetumal                   Protests
#> 6       Telmanivsky                  Dersove Explosions/Remote violence
#>                      sub_event_type interaction fatalities
#> 1                  Peaceful protest          60          0
#> 2                  Peaceful protest          60          0
#> 3 Shelling/artillery/missile attack          10          0
#> 4 Shelling/artillery/missile attack          10          0
#> 5                  Peaceful protest          60          0
#> 6 Shelling/artillery/missile attack          10          0
```


<!-- README.md is generated from README.Rmd. Please edit that file -->

# Automated Retrieval of ACLED Conflict Event Data

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version-last-release/acled.api)](https://CRAN.R-project.org/package=acled.api/)
[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable/)
[![Travis build
status](https://api.travis-ci.com/chris-dworschak/acled.api.svg?branch=master)](https://app.travis-ci.com/gitlab/chris-dworschak/acled.api/)
[![License: CC BY-NC
4.0](https://img.shields.io/badge/License-CC%20BY--NC%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc/4.0/)
[![CRANlogs](http://cranlogs.r-pkg.org/badges/grand-total/acled.api)](https://CRAN.R-project.org/package=acled.api/)
<!-- badges: end -->

This small package provides functionality to access and manage the
application programming interface (API) of the [Armed Conflict Location
& Event Data Project (ACLED)](https://acleddata.com/), while requiring a
minimal number of dependencies. The function `acled.api()` makes it easy
to retrieve a user-defined sample (or all of the available data) of
ACLED, enabling a seamless integration of regular data updates into the
research work flow.

When using this package, you acknowledge that you have read ACLED’s
terms and conditions of use, and that you agree with their attribution
requirements.

## Installation

You can install the latest release version of acled.api from
[CRAN](https://CRAN.R-project.org/package=acled.api/) with:

``` r
install.packages("acled.api") # downloads and installs the package from CRAN
```

You can install the development version from
[GitLab](https://gitlab.com/chris-dworschak/) with:

``` r
remotes::install_gitlab("chris-dworschak/acled.api") # downloads and installs the package from GitLab
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
#> Event Data." R package. CRAN version 1.1.5.
#> For the development version of this package, visit <https://gitlab.com/chris-dworschak/acled.api/>

my.data.frame <- acled.api( # stores an ACLED sample in object my.data.frame
  email.address = Sys.getenv("EMAIL_ADDRESS"),
  access.key = Sys.getenv("ACCESS_KEY"),
  region = c("South Asia", "Central America"), 
  start.date = "2019-09-01", 
  end.date = "2020-01-31")
#> GET request wasn't successful. The API returned status 403: You must confirm you have read and understood the latest terms of use.

my.data.frame[1:5,] # returns the first three observations of the ACLED sample
#> NULL
```

## A note on replicability

Some tasks, like real-time analyses and continuously updated forecasting
models (e.g., as used by practitioners), may not require replicability
of results. However, most research-related tasks assume the possibility
of replication at a later stage (e.g., when results are intended for
publication, or a data project taking multiple days where a change to
the underlying sample is not desirable). After the release of versions 1
through 8, ACLED changed their update system to allow for real-time
amendments and post-release corrections, thereby forgoing traditional
data versioning. This change requires researchers to take additional
steps in order to ensure the replicability of their results when using
ACLED data.

Importantly, downloaded data intended for replicable use must be
permanently stored by the analyst. Data downloaded through `acled.api()`
are only stored temporarily in the working space, and may be lost after
closing R. Therefore, if replicability is important to the analyst’s
task, a call through `acled.api()` should occur only once at the
beginning of the data project, immediately followed by, e.g.,
`saveRDS(downloaded.data, file = "my_acled_data.rds")`. This locally
stored data file can then be used again at a later point by calling
`readRDS(file = "my_acled_data.rds")`, and ensures that the analysis
sample stays constant over time.

ACLED provides a time stamp for each individual observation, enabling
researchers to do “micro versioning” of data points if necessary, and to
verify congruence across samples. For this it is important that
researchers do not drop the variable *timestamp* during the data
management process. Starting version 1.0.9 the function `acled.api()`
includes the *timestamp* variable in its default API call.

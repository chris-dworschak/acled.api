
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
#>  Before using this package to download data, you require an ACLED access key.
#> You can request your key by registering with ACLED on https://developer.acleddata.com/.
#> The package may be cited as:
#> Dworschak, Christoph. 2020. "Acled.api: Automated Retrieval of ACLED Conflict
#> Event Data." R package. CRAN version 1.1.8.
#> For the development version of this package, visit <https://gitlab.com/chris-dworschak/acled.api/>

my.data.frame <- acled.api( # stores an ACLED sample in object my.data.frame
  email.address = Sys.getenv("ACLED_EMAIL_ADDRESS"),
  access.key = Sys.getenv("ACLED_ACCESS_KEY"),
  region = c("South Asia", "Central America"), 
  start.date = "2019-09-01", 
  end.date = "2020-01-31")
#> Your ACLED data request was successful. 
#> Events were retrieved for the period starting 2019-09-01 until 2020-01-31.

my.data.frame[1:5,] # returns the first three observations of the ACLED sample
#>   event_id_cnty          region   country year event_date
#> 1       HND1343 Central America  Honduras 2020 2020-01-31
#> 2       GTM2921 Central America Guatemala 2020 2020-01-31
#> 3      IND70618      South Asia     India 2020 2020-01-31
#> 4      IND70620      South Asia     India 2020 2020-01-31
#> 5      IND70609      South Asia     India 2020 2020-01-31
#>                                       source        admin1      admin2
#> 1                            Proceso Digital        Cortes     La Lima
#> 2 Dialogos - Observatorio sobre la Violencia Huehuetenango La Libertad
#> 3                   Asian News International         Bihar       Patna
#> 4                            Hindustan Times   Maharashtra        Pune
#> 5                            Hindustan Times         Bihar      Kaimur
#>       admin3      location latitude longitude                 event_type
#> 1    La Lima       La Lima  15.4333  -87.9167 Violence against civilians
#> 2            Camoja Grande  15.5823  -91.9006 Violence against civilians
#> 3 Sampatchak         Patna  25.5941   85.1356                   Protests
#> 4  Pune City          Pune  18.5195   73.8553                   Protests
#> 5     Bhabua        Bhabua  25.0404   83.6074                    Battles
#>     sub_event_type interaction fatalities                 tags  timestamp
#> 1           Attack          37          1                      1618511533
#> 2           Attack          37          1                      1618511538
#> 3 Peaceful protest          60          0 crowd size=no report 1649276878
#> 4 Peaceful protest          60          0 crowd size=no report 1649276878
#> 5      Armed clash          44          0                      1649276878
```

## A note on replicability

After the release of versions 1 through 8, ACLED changed their update
system to allow for real-time amendments and post-release corrections,
thereby forgoing traditional data versioning. This change requires
researchers to take additional steps in order to ensure the
replicability of their results when using ACLED data. Some tasks, like
real-time forecasting models used by practitioners, may not require
replicability of intermediate results. However, most research-related
tasks assume the possibility of replication at a later stage. This is
especially the case for results that are intended for publication, or
for an ongoing data project where constant changes to the underlying
sample are not desirable.

To this end, downloaded data intended for replicable use must be
permanently stored by the analyst. Data downloaded through `acled.api()`
are only stored temporarily in the working space, and may be lost after
closing R. Therefore, if replicability is important to the analyst’s
task, a call through `acled.api()` should occur only once at the
beginning of the data project, immediately followed by, e.g.,
`saveRDS(downloaded.data, file = "my_acled_data.rds")`. This locally
stored data file can then be used again at a later point by calling
`readRDS(file = "my_acled_data.rds")`, and ensures that the analysis
sample stays constant over time.

ACLED provides a time stamp for each individual observation (column
*timestamp*), enabling researchers to do “micro versioning” of data
points if necessary, and to verify congruence across samples. Starting
from version 1.0.9, the function `acled.api()` includes the *timestamp*
variable in its default API call. More recently, ACLED also introduced a
discussion of data versioning in its [API
Guide](https://apidocs.acleddata.com/).

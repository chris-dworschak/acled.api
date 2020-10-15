
# Release updates


<!-- Changes for future versions:
* Functionality to do immediate geographic/temporal aggregation as part of the data retrieval
* Functionality for actor-based data retrieval
* New "acled.update" function: the user supplies an existing ACLED data set to the update function, and it flexibly recognizes which ACLED events were added or changed since the user downloaded their data last. Missing events are selectively downloaded to update the existing user data set
 -->

## alced.api version 1.0.7
* Removed LICENSE file based on CRAN recommendation


## alced.api version 1.0.6
* Updated licensing to CC BY-NC 4.0 based on CRAN recommendation


## alced.api version 1.0.5
* Updated licensing
* Bug fix in country argument to support country names containing whitespaces


## alced.api version 1.0.4
* Updated licensing and added file LICENSE
* Minor description revisions


## alced.api version 1.0.3
* Added functionality to retrieve individual countries in addition to regions
* Revised and updated argument information
* Revised argument names
* Added function details
* Revised and updated error messages and warnings
* Added error messages for bad requests/internet connection


## alced.api version 1.0.2

* Added functionality: argument "regions" now also recognizes region names
* Link adjustments
* Removed argument "print.data" due to redudancy
* Added automated numeric variable class recognition and conversion
* Added ACLED T&C to pkg load message
* Revised package and function descriptions
* Conducted more tests
* Revised readme, added badges


## alced.api version 1.0.1

* Minor bug and spelling fixes 
* Title renamed
* Example down-sized


## alced.api version 1.0.0

* This package provides functionality to access and manage the application programming interface (API) of the Armed Conflict Location & Event Data Project (ACLED) at https://www.acleddata.com.
* Arguments included in the first package version: 
  + regions
  + start.date
  + end.date
  + more.variables
  + all.variables
  + dyadic
  + other.query
  + print.data



# Release updates

## alced.api version 1.1.9
* Updates to documentation: 
  + Interaction argument description updated.
  + get.api.regions() updated.
  + Change of URLs to follow ACLED Codebook wandering around again, from https://acleddata.com/resources/general-guides/ to https://acleddata.com/knowledge-base/codebook/.


## alced.api version 1.1.8
* Improved error messages when calls to the API return unsuccessful.
* Addressing ACLED bandwidth limits: 
  + Accommodate empty content returns when bandwidth limit is hit.
  + Give warning message to users when making calls to download the whole dataset.
* Improved descriptions and explanations in Details.
* Adjusted all descriptions to match ACLED's API updates.
* Adjusted get.api.regions() to reflect ACLED's changes to region codes.
* Added the variables event_id_cnty, latitude, longitude, and tags to the default output. 


## alced.api version 1.1.7 (Christmas version)
* Depreciate generic environment variable names for access information, adding "ACLED" to their names.


## alced.api version 1.1.6
* Updated Rd files to HTML5 with current version of roxygen2.
* Fixed links.
* Updated ACLED API country list.


## alced.api version 1.1.5
* Updated description based on GH issue #4
* Updated test-acled: "other.query works" time frame was empty
* Updated test-acled: removed duplicated tests


## alced.api version 1.1.4
* Change of Maintainer email address to permanent address
* Set up support function export for conveniently retrieving region names and codes 
* Added test for get.api.regions()
* 1 merge request by Rob Williams https://github.com/jayrobwilliams 
+ !4 More informative error messages (region & interaction mismatches)
* Other slight revisions to warning messages


## alced.api version 1.1.3
* Resized README example data retrieval
* Updated region names and codes based on new ACLED API guide
* Bug fix in region call
* testthat time frame check adjustment
* testthat modules for region codes
* Updates to arguments access.key and email.address documentation
* Added support function module
* 1 merge request by Rob Williams https://github.com/jayrobwilliams 
+ !3 Bug fix: %20 instead of % for white spaces in country names


## alced.api version 1.1.2
* 1 merge request by Rob Williams https://github.com/jayrobwilliams 
+ !2 Added filter argument "interaction"
* Added Rob Williams as ctb
* Minor revisions
* Updated example in documentation
* Added license badge
* Minor correction to unit tests


## alced.api version 1.1.1
* Travis environment variables push
* 1 merge request by Rob Williams https://github.com/jayrobwilliams 
+ !1 Added unit tests
* Minor README update


## alced.api version 1.1.0
* Improved error messages
* Dev link changes for GitLab switch


## alced.api version 1.0.9
* Adjusted package documentation to address the issue of replicability
* Added the variable "timestamp" to the function's default call
* Other minor DESCRIPTION and README adjustments


## alced.api version 1.0.8
* Adjusted package to accommodate new ACLED access requirements. New arguments are:
  + email.address
  + access.key
* Allow for "graceful fail" if resource not available (accommodating CRAN policy)
* Minor README adjustments


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


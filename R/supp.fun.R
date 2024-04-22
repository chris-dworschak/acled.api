#' @title ACLED API region support function
#' @name get.api.regions
#' @description List of region names and codes as they are supplied by the [ACLED API user guide](https://acleddata.com/resources/general-guides/).
#' @details This single-purpose support function does not take arguments. It is set up as a convenient way to return region names and region codes
#' to be used in the _`acled.api()`_ main function's region argument.
#' @return A list of length 2. \cr
#' 1. A data frame object containing ACLED region names and codes. \cr
#' 2. A string with version information.
#' @author Christoph Dworschak \cr Website: \url{https://www.chrisdworschak.com/}
#' @references Armed Conflict Location & Event Data Project (ACLED) [API user guide](https://acleddata.com/resources/general-guides/) \cr
#' Clionadh Raleigh, Andrew Linke, Havard Hegre and Joakim Karlsen. 2010.
#' "Introducing ACLED-Armed Conflict Location and Event Data." _Journal of Peace Research_ 47 (5): 651-660.
#' @export
#'
get.api.regions <- function(){
  region.names <- list(
    data.frame(
      region = c("Western Africa", "Middle Africa", "Eastern Africa", "Southern Africa", "Northern Africa",
             "South Asia", "Southeast Asia",
             "Middle East", "Europe", "Caucasus and Central Asia", "Central America", "South America", "Caribbean",
             "East Asia", "North America", "Oceania", "Antarctica"),
      code = c(1,2,3,4,5,
           7,9,
           11,12,13,14,15,16,
           17, 18, 19, 20)),
    "Last update from https://acleddata.com/resources/general-guides/: ACLED API User Guide version February 2022, API Version 3.4")

  return(region.names)

}


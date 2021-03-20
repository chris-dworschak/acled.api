
get.api.regions <- function(){
  region.names <- list(
    data.frame(
      region = c("Western Africa", "Middle Africa", "Eastern Africa", "Southern Africa", "Northern Africa",
             "South Asia", "Western Asia", "Southeast Asia",
             "Middle East", "Europe", "Caucasus and Central Asia", "Central America", "South America", "Caribbean",
             "East Asia", "North America"),
      code = c(1,2,3,4,5,
           7,8,9,
           11,12,13,14,15,16,
           17, 18)),
    "Last update from https://acleddata.com/resources/general-guides/: ACLED API User Guide version February 2021, API Version 3.2")

  return(region.names)

}




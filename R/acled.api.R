#' @title Automated Retrieval of ACLED Conflict Event Data
#' @name acled.api
#' @description This small package provides functionality to access and manage the application programming
#' interface (API) of the [Armed Conflict Location & Event Data Project (ACLED)](https://acleddata.com/).
#' The function _`acled.api()`_ makes it easy to retrieve a user-defined sample (or all of the
#' available data) of ACLED, enabling a seamless integration of regular data updates into
#' the research work flow. \cr \cr
#' When using this package, you acknowledge that you have read ACLED's terms and
#' conditions of use, and that you agree with their attribution requirements.
#' @param country character vector. Supply one or more country names to narrow down which events should be retrieved. See the details
#' below for information on how the arguments "country" and "region" interact.
#' @param region numeric or character vector. Supply one or more region codes (numeric) or region names (character)
#' to narrow down which events should be retrieved (see [ACLED's codebook](https://acleddata.com/resources/general-guides/)
#' for details on region codes and names). See the details below for information on how the arguments "country" and "region" interact.
#' @param start.date character string. Supply the earliest date to be retrieved. Format: "yyyy-mm-dd".
#' @param end.date character string. Supply the last date to be retrieved. Format: "yyyy-mm-dd".
#' @param add.variables character vector. Supply the names of ACLED variables you wish to add to the
#' default output (see [ACLED's codebook](https://acleddata.com/resources/general-guides/) for details). The default
#' output includes: region, country, year, event_date, source, admin1, admin2, admin3, location, event_type, sub_event_type,
#' interaction, fatalities.
#' @param all.variables logical. When set to FALSE (default), a narrow default selection of variables is returned (which
#' can be refined using the argument add.variables). If set to TRUE, all variables are included in the output (overrides
#' argument add.variables).
#' @param dyadic logical. When set to FALSE (default), monadic data is returned (one
#' observation per event). If set to TRUE, dyadic data is returned.
#' @param other.query character vector. Allows users to add their own ACLED API queries to the
#' GET call. Vector elements are assumed to be individual queries, and are automatically separated by an & sign.
#' @details The function _`acled.api()`_ is an R wrapper for
#' the [Armed Conflict Location & Event Data Project](https://acleddata.com/) API.
#' Internally it uses _`httr`_ to access the API, and _`jsonlite`_ to manage the JSON content that the call returns. The JSON data
#' are converted into the base class _`data.frame`_. Variables are of class _`character`_ by default.
#' Variables which only contain numbers as recognized by the regular
#' expression `^[0-9]+$` are coerced into _`numeric`_ before the _`data.frame`_ object is returned. \cr \cr
#' If both the country argument and the region argument are NULL (default), all available countries are retrieved. The same applies to
#' the time frame when both the start date and the end date are NULL (default). Note that the API cannot handle requests with only one
#' of the dates specified (either none of them or both of them need to be supplied). \cr \cr
#' The ACLED API combines the country argument and the region argument with a logical AND operator. Therefore, specifying e.g. the
#' country "Togo" and the region "Southern Africa" leads the API to query for a country named "Togo" in the region "Southern Africa".
#' In this case, no data will be returned as no events match this query.
#' @return A data frame containing ACLED events.
#' @import jsonlite
#' @import httr
#' @author Christoph Dworschak \cr Website: \href{https://www.chrisdworschak.com/}{<https://chrisdworschak.com/>}
#' @references Armed Conflict Location & Event Data Project (ACLED); <https://acleddata.com/> \cr
#' Clionadh Raleigh, Andrew Linke, Havard Hegre and Joakim Karlsen. 2010.
#' "Introducing ACLED-Armed Conflict Location and Event Data." _Journal of Peace Research_ 47 (5): 651-660.
#' @examples
#' my.data.frame1 <- acled.api(region = c(1,7),
#' start.date = "2018-11-01",
#' end.date = "2018-11-31")
#' head(my.data.frame1)
#'
#' my.data.frame2 <- acled.api(region = c(1,7),
#' start.date = "2018-11-01",
#' end.date = "2018-11-31",
#' add.variables = c("geo_precision", "time_precision"))
#' sd(my.data.frame2$geo_precision)
#' @export
#'
acled.api <- function(
  country = NULL,
  region = NULL,
  start.date = NULL,
  end.date = NULL,
  add.variables = NULL,
  all.variables = FALSE,
  dyadic = FALSE,
  other.query = NULL){

  # accept terms
  terms <- "read?terms=accept&limit=0"

  # country argument
  if ( (!is.null(country) & !is.character(country)) == TRUE ) {
    stop('If you wish to specify country names, these need to be supplied as a character vector.
    Usage example: \n
         acled.api(country = c("Kenya", "Togo"), start.date = "2004-08-20", end.date = "2005-05-15")', call. = FALSE)
  }
  if(is.character(country) == TRUE){
    country1 <- paste0("&country=",
                       paste( gsub("\\s{1}", "%", country), collapse = "|")) }
  if(is.null(country) == TRUE){
    country1 <- ""
  }

  # region argument
  if ( (!is.null(region) & !is.numeric(region) & !is.character(region)) == TRUE ) {
    stop('If you wish to specify regions, these need to be supplied as a numeric vector (region codes) or character
    vector (region names). See the ACLED codebook for region names and codes.
    Usage example: \n
         acled.api(region = c(1,2), start.date = "2004-08-20", end.date = "2005-05-15") or \n
         acled.api(region = c("Western Africa", "Middle Africa"), start.date = "2004-08-20", end.date = "2005-05-15")', call. = FALSE)
  }
  if(is.numeric(region) == TRUE){
    region1 <- paste0("&region=", paste(region, collapse = "|") )
  }
  region.data.frame <- data.frame(
    region = c("Western Africa", "Middle Africa", "Eastern Africa", "Southern Africa", "Northern Africa",
               "Southern Asia", "Western Asia", "South-Eastern Asia", "South Asia",
               "Middle East", "Europe", "Caucasus and Central Asia", "Central America", "South America", "Caribbean"),
    code = c(1,2,3,4,5,
             7,8,9,10,
             11,12,13,14,15,16))
  if(is.character(region) == TRUE){
    char.region <- which(region.data.frame$region%in%region)
    region1 <- paste0("&region=", paste(char.region, collapse = "|") )
        if(length(region) != length(char.region)){
          warning('At least one of the region names supplied in argument "region = " does not match the original
              ACLED region names. Check your spelling, or the ACLED codebook for the correct names.', call. = FALSE)
        }
  }
  if(is.null(region) == TRUE){
    region1 <- ""
  }

  # start.date & end.date arguments
  if ( (is.null(start.date) & is.null(end.date)) == FALSE ){
    if( (is.null(start.date) | is.null(end.date)) == TRUE){
    stop("You need to supply either no start date and no end date, in which case all available dates are requested, or both
    a start date and an end date.
    Usage example: \n
         acled.api(region = c(1), start.date = '1995-01-15', end.date = '2005-12-15') or
         acled.api(region = c(1), start.date = NULL, end.date = NULL)", call. = FALSE)
    }
    if ( start.date>end.date ) {
      stop("The start date cannot be larger than the end date.", call. = FALSE)
    }
  }
  time.frame1 <- paste0("&event_date=", paste(start.date, end.date, sep = "|"), "&event_date_where=BETWEEN")

  # add.variables and all.variables argument
  if( is.logical(all.variables)==TRUE ){
    if( all.variables==FALSE ){
        if( is.null(add.variables)==TRUE ){
          variables <- "&fields=region|country|year|event_date|source|admin1|admin2|admin3|location|event_type|sub_event_type|interaction|fatalities"
          }else{
            variables <- paste0("&fields=region|country|year|event_date|source|admin1|admin2|admin3|location|event_type|sub_event_type|interaction|fatalities",
                        "|", paste(add.variables, collapse = "|") )
            }
      }else{
          variables <- ""
          }
    }else{
      stop("The argument 'all.variables' requires a logical value.", call. = FALSE)
  }

  # dyadic argument
  if( is.logical(dyadic)==TRUE ){
      dyadic1 <- ifelse(dyadic==FALSE, "&?export_type=monadic", "")}else{
        stop("The argument 'dyadic' requires a logical value.", call. = FALSE)
  }

  # other.query argument
  other.query1 <- ifelse( is.null(other.query)==TRUE, "", paste0("&", paste(other.query, collapse = "&")) )


  # GET call
  url <- paste0("https://api.acleddata.com/acled/", terms, dyadic1, time.frame1, variables, country1, region1, other.query1)
  response <- httr::GET(url)

  if ( exists("response")==FALSE ) {
    stop("GET request was unsuccessful. Check your internet connection. If the problem persists despite a reliable internet connection,
    the server may be temporarily not reachable; in this case try again later.",
    call. = FALSE)
  }
  if (httr::http_type(response) != "application/json") {
    stop(paste0("GET request was unsuccessful: the API did not return a JSON file, giving the status code ",
                response$status_code, "."), call. = FALSE)
  }

  # JSON
  json.content <- jsonlite::fromJSON( httr::content(response, "text", encoding = 'UTF-8'),
                            simplifyVector = FALSE)
  if(!json.content$success){
    stop(paste0("GET request wasn't successful: ", json.content$error$message))
  }
  json.content <- json.content$data

  if( length(json.content)==0L ){
    message("No data found for this area and time period.
            Or did you supply both countries and (other) regions? These cannot be combined.")
    return(NULL)
  }

  # data prep
  acled.matrix <- matrix( unlist(json.content),
                          byrow = T,
                          nrow = length(json.content) )

  acled.data <- data.frame(acled.matrix, stringsAsFactors = FALSE)
  names(acled.data) <- names(json.content[[1L]])

  for(i in 1:ncol(acled.data)){
    if( all(grepl("^[0-9]+$", acled.data[,i], perl = T))==TRUE ){
      acled.data[,i] <- as.numeric(acled.data[,i])}
  }

  message(paste0("Your ACLED data request was successful.
                 Events were retrieved for the period starting ",
                    range(acled.data$event_date)[1], " until ", range(acled.data$event_date)[2], "."))

  acled.data

}

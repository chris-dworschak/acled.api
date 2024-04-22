#' @title Automated Retrieval of ACLED Conflict Event Data
#' @name acled.api
#' @description Access and manage the application programming interface (API)
#' of the [Armed Conflict Location & Event Data Project (ACLED)](https://acleddata.com/).
#' The function _`acled.api()`_ makes it easy to retrieve a user-defined sample (or all of the
#' available data) of ACLED, enabling a seamless integration of regular data updates into
#' the research work flow. If the data are intended for replicable use (e.g., later publication of analysis results), the
#' downloaded data should be stored locally after retrieval. See the package's README file for a
#' note on replicability when using ACLED data. \cr \cr
#' When using this package, you acknowledge that you have read ACLED's terms and
#' conditions of use, and that you agree with their attribution requirements.
#' @param email.address character string. Supply the email address that you registered with [ACLED access](https://developer.acleddata.com/).
#' The email address can also be set as an environment variable using _`Sys.setenv(ACLED_EMAIL_ADDRESS="your.email.address")`_, in
#' which case this argument can be skipped. Usage examples below illustrate these two approaches.
#' @param access.key character string. Supply your ACLED access key. The  access key can also be set as an environment variable
#' using _`Sys.setenv(ACLED_ACCESS_KEY="your.access.key")`_, in which case this argument can be skipped. Usage examples below illustrate these two approaches.
#' @param country character vector. Supply one or more country names to narrow down which events should be retrieved. See the details
#' below for information on how the arguments "country" and "region" interact.
#' @param region numeric or character vector. Supply one or more region codes (numeric) or region names (character)
#' to narrow down which events should be retrieved. You can run `get.api.regions()` to view supported region codes and names,
#' or see [ACLED's API Guide](https://apidocs.acleddata.com/).
#' See the details below for information on how the arguments "country" and "region" interact.
#' @param start.date character string. Supply the earliest date to be retrieved. Format: "yyyy-mm-dd".
#' @param end.date character string. Supply the last date to be retrieved. Format: "yyyy-mm-dd".
#' @param add.variables character vector. Supply the names of ACLED variables you wish to add to the
#' default output (see [ACLED's codebook](https://acleddata.com/resources/general-guides/) for details). The default
#' output includes: event_id_cnty, region, country, year, event_date, source, admin1, admin2, admin3, location, latitude, longitude, event_type, sub_event_type,
#' interaction, fatalities, tags, and the download timestamp.
#' @param all.variables logical. When set to FALSE (default), a narrow default selection of variables is returned (which
#' can be refined using the argument add.variables). If set to TRUE, all variables are included in the output (overrides
#' argument add.variables).
#' @param dyadic logical. When set to FALSE (default), monadic data is returned (one
#' observation per event). If set to TRUE, dyadic data is returned.
#' @param interaction numeric vector. Supply one or more interaction codes to narrow down which events should be
#' retrieved (see [ACLED's codebook](https://acleddata.com/resources/general-guides/) for details.
#' @param other.query character vector. Allows users to add their own ACLED API queries to the
#' GET call. Vector elements are assumed to be individual queries, and are automatically separated by an & sign.
#' See [ACLED's API Guide](https://apidocs.acleddata.com/) for information on making your custom query.
#' @details The function _`acled.api()`_ is an R wrapper for
#' the [Armed Conflict Location & Event Data Project](https://acleddata.com/) API.
#' Internally it uses _`httr`_ to access the API, and _`jsonlite`_ to manage the JSON content that the call returns. The JSON data
#' are converted into the base class _`data.frame`_. Variables are of class _`character`_ by default.
#' Variables which only contain numbers as recognized by the regular
#' expression `^[0-9]+$` are coerced into _`numeric`_ before the _`data.frame`_ object is returned. \cr \cr
#' *Authentification:* The user's registered email address and ACLED access key, which they obtain after registering with [ACLED access](https://developer.acleddata.com/), can be supplied as strings directly to their respective arguments,
#' or set in advance as environment variables
#' using \cr _`Sys.setenv(ACLED_EMAIL_ADDRESS="your.email.address")`_ and \cr _`Sys.setenv(ACLED_ACCESS_KEY="your.access.key")`_. \cr \cr
#' *Retrieving all data at once:* If both the country argument and the region argument are NULL (default), all available countries are retrieved. The same applies to
#' the time frame when both the start date and the end date are NULL (default). Note that the API cannot handle requests with only one
#' of the dates specified (either none of them or both of them need to be supplied). More recent versions of the API implemented a bandwidth limit that prevents
#' users from retrieving larger amounts of data in a single call. At the time of this writing (v. _`acled.api()`_ 1.1.8), ACLED recommends using pagination to retrieve data
#' in separate calls of 5000 rows each. This is much less than what is actually possible to retrieve in a single call, and with a full dataset of >2 million rows, pagination is less
#' practicable than simply downloading by individual regions or time periods. The separate data chunks obtained this way can then be combined using rbind(). Users who want to make use of
#' pagination can do so using the _`other.query`_ filter. \cr \cr
#' *Filter combinations:* By default, _`acled.api()`_ combines different filters with a logical AND operator.
#' This usually conforms with desired behavior, with the country argument and the region argument as important exception: for example, specifying the
#' country "Togo" and the region "Southern Africa" leads the API to query for a country named "Togo" in the region "Southern Africa".
#' In this case, no data will be returned as no events match this query, and it is recommended to make two separate calls, one for Togo and one for Southern Africa.
#' More recent versions of the API also support OR operators to separate filters. These can be implemented through _`acled.api()`_ by using the _`other.query`_ filter.
#' To do so, see the [ACLED API Guide](https://apidocs.acleddata.com/) for details.
#' @return A data frame containing ACLED events.
#' @import jsonlite
#' @import httr
#' @author Christoph Dworschak \cr Website: \url{https://www.chrisdworschak.com/}
#' @references Armed Conflict Location & Event Data Project (ACLED); <https://acleddata.com/> \cr
#' Clionadh Raleigh, Andrew Linke, Havard Hegre and Joakim Karlsen. 2010.
#' "Introducing ACLED-Armed Conflict Location and Event Data." _Journal of Peace Research_ 47 (5): 651-660.
#' @examples
#' \dontrun{
#' # Email and access key provided as strings:
#' my.data.frame1 <- acled.api(
#'   email.address = "your.email.address",
#'   access.key = "your.access.key",
#'   region = c(1,7),
#'   start.date = "2018-11-01",
#'   end.date = "2018-11-31")
#' head(my.data.frame1)
#'
#' # Email and access key provided as environment variables:
#' my.data.frame2 <- acled.api(
#'   email.address = Sys.getenv("ACLED_EMAIL_ADDRESS"),
#'   access.key = Sys.getenv("ACLED_ACCESS_KEY"),
#'   region = c(1,7),
#'   start.date = "2020-01-01",
#'   end.date = "2020-11-31",
#'   interaction = c(10:18, 22:28),
#'   add.variables = c("geo_precision", "time_precision"))
#' sd(my.data.frame2$geo_precision)
#' }
#' @export
#'
acled.api <- function(
  email.address = Sys.getenv("ACLED_EMAIL_ADDRESS"),
  access.key = Sys.getenv("ACLED_ACCESS_KEY"),
  country = NULL,
  region = NULL,
  start.date = NULL,
  end.date = NULL,
  add.variables = NULL,
  all.variables = FALSE,
  dyadic = FALSE,
  interaction = NULL,
  other.query = NULL){


  # access key
  legacy <- c(0,0)
  legacy.key <- Sys.getenv("ACCESS_KEY")
  if( (is.null(access.key) | !is.character(access.key) | access.key=="" ) == TRUE ) {
    if( (is.null(legacy.key) | !is.character(legacy.key) | legacy.key=="" ) == TRUE ) {
      stop('ACLED requires an access key, which needs to be supplied to the argument "access.key" as a character string.
    You can request an access key by registering on https://developer.acleddata.com/.', call. = FALSE)
    }else{
      if( (is.character(legacy.key) & legacy.key!="") == TRUE){
        access.key1 <- paste0("key=", legacy.key)
        legacy[1] <- 1 }}
  }else{
    if( (is.character(access.key) & access.key!="") == TRUE){
      access.key1 <- paste0("key=", access.key)}
  }

  # email address
  legacy.email <- Sys.getenv("EMAIL_ADDRESS")
  if ( (is.null(email.address) | !is.character(email.address) | email.address=="") == TRUE ) {
    if ( (is.null(legacy.email) | !is.character(legacy.email) | legacy.email=="") == TRUE ) {
      stop('ACLED requires an email address for access, which needs to be supplied to the argument "email.address" as a character string.
    Use the email address you provided when registering on https://developer.acleddata.com/.', call. = FALSE)
    }else{
      if( (is.character(legacy.email) & legacy.email!="") == TRUE){
        email.address1 <- paste0("&email=", legacy.email)
        legacy[2] <- 1 }}
  }else{
    if( (is.character(email.address) & email.address!="") == TRUE){
      email.address1 <- paste0("&email=", email.address)}
  }

  if(sum(legacy)==2){
    warning('Please update your environment variable names to "ACLED_ACCESS_KEY" and "ACLED_EMAIL_ADDRESS". The generic names "ACCESS_KEY" and "EMAIL_ADDRESS" are depreceated.')
  }

  # country argument
  if ( (!is.null(country) & !is.character(country)) == TRUE ) {
    stop('If you wish to specify country names, these need to be supplied as a character vector.
Usage example:
         acled.api(country = c("Kenya", "Togo"), start.date = "2004-08-20", end.date = "2005-05-15")', call. = FALSE)
  }
  if(is.character(country) == TRUE){
    country1 <- paste0("&country=",
                       paste( gsub("\\s{1}", "%20", country), collapse = "|")) }
  if(is.null(country) == TRUE){
    country1 <- ""
  }

  # region argument
  if ( (!is.null(region) & !is.numeric(region) & !is.character(region)) == TRUE ) {
    stop('If you wish to specify regions, these need to be supplied as a numeric vector (region codes) or character
vector (region names). See the ACLED API guide for exact region names and codes.
Usage example:
         acled.api(region = c(1,2), start.date = "2004-08-20", end.date = "2005-05-15") or
         acled.api(region = c("Western Africa", "Middle Africa"), start.date = "2004-08-20", end.date = "2005-05-15")', call. = FALSE)
  }
  region.data.frame <- get.api.regions()[[1]]
  if(is.numeric(region) == TRUE){
    if(!all(region%in%region.data.frame$code)){
      invalid.region <- region[!region%in%region.data.frame$code]
      warning(paste0("Region ",
                     ifelse(length(invalid.region) > 1, "codes ", "code "),
                     paste(sub("(.*)", "'\\1'", invalid.region),
                           collapse = ", "),
                     " supplied in argument 'region' ",
                     ifelse(length(invalid.region) > 1, "do", "does"),
                     " not match the original ACLED region codes.\n",
                     "Check your spelling, and see the ACLED API guide",
                     " for the correct codes or run get.api.regions()."), call. = FALSE)
      }
    region1 <- paste0("&region=", paste(region, collapse = "|") )
  }
  if(is.character(region) == TRUE){
    char.region <- region.data.frame$code[which(region.data.frame$region%in%region)]
    region1 <- paste0("&region=", paste(char.region, collapse = "|") )
        if(length(region) != length(char.region)){
          invalid.region <- region[!region %in% region.data.frame$region]
          warning(paste0("Region ",
                         ifelse(length(invalid.region) > 1, "names ", "name "),
                         paste(paste0("'", invalid.region, "'"), collapse = ", "),
                         " supplied in argument 'region' ",
                         ifelse(length(invalid.region) > 1, "do", "does"),
                         " not match the original ACLED region names.\n",
                         "Check your spelling, and see the ACLED API guide",
                         " for the correct names or run get.api.regions()."), call. = FALSE)
         }
  }
  if(is.null(region) == TRUE){
    region1 <- ""
  }

  # start.date & end.date arguments
  if ( (is.null(start.date) & is.null(end.date)) == FALSE ){
    if( (is.null(start.date) | is.null(end.date)) == TRUE){
    stop("You need to supply either no start date and no end date, in which case all available dates are requested, or both a start date and an end date.
Usage example:
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
          variables <- "&fields=event_id_cnty|region|country|year|event_date|source|admin1|admin2|admin3|location|latitude|longitude|event_type|sub_event_type|interaction|fatalities|tags|timestamp"
          }else{
            variables <- paste0("&fields=event_id_cnty|region|country|year|event_date|source|admin1|admin2|admin3|location|latitude|longitude|event_type|sub_event_type|interaction|fatalities|tags|timestamp",
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

  # interaction argument
  if(!(is.numeric(interaction) | is.null(interaction))) {
    stop("The 'interaction' argument requires a numeric value.")
  }
  if(!all(interaction %in% c(10:18, 20, 22:28, 30, 33:38, 40, 44:48, 50,
                             55:58, 60, 66, 68, 78, 80))){
    invalid.interaction <- interaction[!interaction %in% c(10:18, 20, 22:28, 30,
                                                           33:38, 40, 44:48, 50,
                                                           55:58, 60, 66, 68,
                                                           78, 80)]
    warning(paste0("Interaction ",
                ifelse(length(invalid.interaction) > 1, "codes ", "code "),
                paste(invalid.interaction, collapse = ', '),
                " supplied to the argument 'interaction'",
                ifelse(length(invalid.interaction) > 1, " do", " does"),
                " not match the",
                " original ACLED interaction codes.\n",
                "Check the ACLED codebook for the correct codes."), call. = FALSE)
  }
  interaction1 <- ifelse(is.null(interaction)==TRUE, "",
                         paste0("&", paste0("interaction=", interaction, collapse = ":OR:")))

  # other.query argument
  other.query1 <- ifelse( is.null(other.query)==TRUE, "", paste0("&", paste(other.query, collapse = "&")) )

  # bandwidth limit warning
  if ( (is.null(start.date) & is.null(end.date) & is.null(region) & is.null(country)) == TRUE ) {
    warning('You are trying to download data for all available regions and time periods.
ACLED has bandwidth restrictions that may prevent you from doing so.
This can be solved by making several smaller calls, separately downloading individual regions or time periods.
After downloading the data in these chunks, you can then combine them with rbind().', call. = FALSE)
  }

  # ACLED ping
  acled.url.ping <- tryCatch(
    httr::GET("https://api.acleddata.com/"),
    error = function(e) e )
  if( any(class(acled.url.ping) == "error") ) {
    message("The resource api.acleddata.com cannot be reached.
    1. Please check your internet connection.
    2. If the internet connection is reliable, the server may be temporarily unavailable; in this case please try again later.
    3. If the problem persists, please contact the package maintainer as the resource may have moved.")
    return(NULL)
  }


  # GET call
  url <- paste0("https://api.acleddata.com/acled/read/?",
                access.key1, email.address1, "&limit=0", dyadic1, time.frame1, variables, country1, region1, interaction1, other.query1)

  response <- httr::GET(url)
  if ( exists("response")==FALSE ) {
    message("GET request was unsuccessful. Please check your internet connection. If the problem persists despite a reliable internet connection,
the server may be temporarily not available; in this case try again later.")
    return(NULL)
  }
  if (httr::http_type(response) != "application/json" | length(response$content)==0) {
    message(paste0("GET request was unsuccessful, giving the status code ",
                response$status_code, ". \n For information on status codes, see https://apidocs.acleddata.com/ and https://developer.mozilla.org/en-US/docs/Web/HTTP/Status.
                \n If you are trying to download a large dataset (e.g., multiple regions over time), you may be hitting ACLED bandwidth restrictions.
  This can be solved by making several smaller calls, separately downloading individual regions or time periods.
  After downloading the data in these chunks, you can then combine them with rbind()."))
    return(NULL)
  }

  # JSON
  json.content <- jsonlite::fromJSON( httr::content(response, "text", encoding = 'UTF-8'),
                            simplifyVector = FALSE)
  if(!json.content$success){
    message(paste0("GET request wasn't successful. The API returned status ", json.content$error$status, ": ", json.content$error$message, "."))
    return(NULL)
  }
  json.content <- json.content$data

  if( length(json.content)==0L ){
    message("No data found for this area, time period, and/or page.
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

  message(paste0("Your ACLED data request was successful. \nEvents were retrieved for the period starting ",
                    range(acled.data$event_date)[1], " until ", range(acled.data$event_date)[2], "."))



  # return the final data frame
  acled.data

}

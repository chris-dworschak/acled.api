#' @title acled.api: Automated retrieval of ACLED conflict event data
#' @name acled.api
#' @description Use acled.api() to access the application programming interface (API) of
#' the \href{https://www.acleddata.com}{Armed Conflict Location & Event Data
#' Project (ACLED) at https://www.acleddata.com}. \n \n
#' When using this package, you acknowledge that you have read ACLED's terms and conditions
#' of use, and that you agree with their attribution requirements.
#' @param regions numeric vector. Required. Supply one or a vector of multiple ACLED region
#' numbers (see ACLED's codebook for details).
#' @param start.date character string. Required. Enter the earliest date to be retrieved. Format: "yyyy-mm-dd".
#' @param end.date character string. Required. Enter the last date to be retrieved. Format: "yyyy-mm-dd".
#' @param more.variables character vector. Optional. Supply the names of ACLED variables you wish to add to the
#' default output (see ACLED's codebook for details). Variables that are always are: region, country, year,
#' event_date, source, admin1, admin2, admin3, location, event_type, sub_event_type, interaction, fatalities.
#' @param dyadic logical. Optional. When set to NULL (default) or FALSE, monadic data is returned (one
#' observation per event). If set to TRUE, dyadic data is returned.
#' @param other.query character vector. Optional. Allows users to add their own ACLED API queries to the
#' GET call. Note that some query terms require a ? in front.
#' @return A data frame object containing ACLED events.
#' @import jsonlite
#' @import httr
#' @author Christoph Dworschak \n Website: \href{https://www.chrisdworschak.com}{chrisdworschak.com}
#' @references Armed Conflict Location & Event Data Project (ACLED); https://www.acleddata.com
#' @examples
#' my.data.frame1 <- acled.api(regions = c(1,2,7), \n start.date = "2018-01-15", \n end.date = "2018-12-31") \n
#' head(my.data.frame1)  \n \n
#' my.data.frame2 <- acled.api(regions = c(1,2,7), \n start.date = "2018-01-15", \n end.date = "2018-12-31", \n
#' more.variables = c("geo_precision", "time_precision")) \n
#' sd(my.data.frame2$geo_precision)
#' @export
#'
acled.api <- function(
  regions = NULL,
  start.date = NULL,
  end.date = NULL,
  more.variables = NULL,
  dyadic = NULL,
  other.query = NULL){

  terms <- "read?terms=accept&limit=0"

  if (is.null(regions) | !is.numeric(regions) == TRUE) {
    stop("You need to supply a number or a vector of numbers to indicate the geographic regions you wish to retrieve
    (see ACLED's codebook for region codes). For example use: \n
         acled_data(regions = c(1), start.date = '1995-01-15', end.date = '2005-12-15')", call. = FALSE)
  }
  regions1 <- paste0("&region=", paste(regions, collapse = "|") )

  if (is.null(start.date) | is.null(end.date) == TRUE) {
    stop("You need to supply both a start date and an end date. For example use: \n
         acled_data(regions = c(1), start.date = '1995-01-15', end.date = '2005-12-15')", call. = FALSE)
  }else{
    if ( start.date>end.date ) {
      stop("The start date cannot be larger than the end date.", call. = FALSE)
    }
  }
  time.frame1 <- paste0("&event_date=", paste(start.date, end.date, sep = "|"), "&event_date_where=BETWEEN")

  if( is.null(more.variables)==TRUE ){
    variables <- "&fields=region|country|year|event_date|source|admin1|admin2|admin3|location|event_type|sub_event_type|interaction|fatalities"
  }else{
    variables <- paste0("&fields=region|country|year|event_date|source|admin1|admin2|admin3|location|event_type|sub_event_type|interaction|fatalities",
                        "|", paste(more.variables, collapse = "|") )
  }

  if( is.null(dyadic)==TRUE ){
  dyadic1 <- "&?export_type=monadic"}else{
    if( is.logical(dyadic)==TRUE ){
      dyadic1 <- ifelse(dyadic==FALSE, "&?export_type=monadic", "")}else{
        stop("The argument 'dyadic' requires a logical value or must be set to NULL.", call. = FALSE)
      }
  }

  other.query1 <- ifelse( is.null(other.query)==TRUE, "", paste0("&", paste(other.query, collapse = "&")) )




  url <- paste0("https://api.acleddata.com/acled/", terms, dyadic1, time.frame1, variables, regions1, other.query1)
  response <- httr::GET(url)
  if (httr::http_type(response) != "application/json") {
    stop("API did not return a json file.", call. = FALSE)
  }

  json.content <- jsonlite::fromJSON( httr::content(response, "text", encoding = 'UTF-8'),
                            simplifyVector = FALSE)
  if(!json.content$success){
    stop(paste0("Request wasn't successful: ", json.content$error$message))
  }
  json.content <- json.content$data
  if( length(json.content)==0L )return(NULL)
  acled.matrix <- matrix( unlist(json.content),
                          byrow = T,
                          nrow = length(json.content))

  acled.data <- data.frame(acled.matrix, stringsAsFactors = FALSE)
  names(acled.data) <- names(json.content[[1L]])

  message(
    paste0("Your ACLED data request was successful. ",
           length(unique(acled.data$region)), " regions were retrieved for the time starting ",
           range(acled.data$event_date)[1], " until ", range(acled.data$event_date)[2], ".")
  )
  return(acled.data)

}

#' @title Automated Retrieval of ACLED Conflict Event Data
#' @name acled.api
#' @description A small package to access the application programming interface (API) of
#' the Armed Conflict Location & Event Data
#' Project (ACLED) at \href{https://www.acleddata.com/}{<https://www.acleddata.com/>}. \cr \cr
#' When using this package, you acknowledge that you have read ACLED's terms and conditions
#' of use, and that you agree with their attribution requirements.
#' @param regions required numeric vector. Supply one or a vector of multiple integers indicating the geographic region
#' you wish to retrieve (see ACLED's codebook for details on region variable indicators).
#' @param start.date required character string. Supply the earliest date to be retrieved. Format: "yyyy-mm-dd".
#' @param end.date required character string. Supply the last date to be retrieved. Format: "yyyy-mm-dd".
#' @param more.variables optional character vector. Supply the names of ACLED variables you wish to add to the
#' default output (see ACLED's codebook for details). Variables that are always are: region, country, year,
#' event_date, source, admin1, admin2, admin3, location, event_type, sub_event_type, interaction, fatalities.
#' @param all.variables optional logical. When set to FALSE (default), a default selection of variables is returned, which
#' can be refined using the argument more.variables). If set to TRUE, all variables are included in the output (overrides
#' argument more.variables).
#' @param dyadic optional logical. When set to FALSE (default), monadic data is returned (one
#' observation per event). If set to TRUE, dyadic data is returned.
#' @param other.query optional character vector. Allows users to add their own ACLED API queries to the
#' GET call. Note that some query terms require a ? in front.
#' @param print.data optional logical. When set to FALSE (default), a message is returned that confirms the
#' successful data access. If set to TRUE, the whole retrieved data set is returned.
#' @return A data frame object containing ACLED events.
#' @import jsonlite
#' @import httr
#' @author Christoph Dworschak \cr Website: \href{https://www.chrisdworschak.com/}{<https://chrisdworschak.com/>}
#' @references Armed Conflict Location & Event Data Project (ACLED); <https://www.acleddata.com> \cr
#' Clionadh Raleigh, Andrew Linke, Havard Hegre and Joakim Karlsen. 2010.
#' "Introducing ACLED-Armed Conflict Location and Event Data." Journal of Peace Research 47 (5): 651-660.
#' @examples
#' my.data.frame1 <- acled.api(regions = c(1,2,7),
#' start.date = "2018-11-01",
#' end.date = "2018-11-31")
#' head(my.data.frame1)
#'
#' my.data.frame2 <- acled.api(regions = c(1,2,7),
#' start.date = "2018-11-01",
#' end.date = "2018-11-31",
#' more.variables = c("geo_precision", "time_precision"))
#' sd(my.data.frame2$geo_precision)
#' @export
#'
acled.api <- function(
  regions = NULL,
  start.date = NULL,
  end.date = NULL,
  more.variables = NULL,
  all.variables = FALSE,
  dyadic = FALSE,
  other.query = NULL,
  print.data = FALSE){

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

  if( is.logical(all.variables)==TRUE ){
    if( all.variables==FALSE ){
        if( is.null(more.variables)==TRUE ){
          variables <- "&fields=region|country|year|event_date|source|admin1|admin2|admin3|location|event_type|sub_event_type|interaction|fatalities"
          }else{
            variables <- paste0("&fields=region|country|year|event_date|source|admin1|admin2|admin3|location|event_type|sub_event_type|interaction|fatalities",
                        "|", paste(more.variables, collapse = "|") )
            }
      }else{
          variables <- ""
          }
    }else{
      stop("The argument 'all.variables' requires a logical value.", call. = FALSE)
  }

  if( is.logical(dyadic)==TRUE ){
      dyadic1 <- ifelse(dyadic==FALSE, "&?export_type=monadic", "")}else{
        stop("The argument 'dyadic' requires a logical value.", call. = FALSE)
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

  if( is.logical(print.data)==TRUE ){
    if(print.data==TRUE){ print(acled.data) }else{ message(
             paste0("Your ACLED data request was successful. ",
                    length(unique(acled.data$region)), " regions were retrieved for the time starting ",
                    range(acled.data$event_date)[1], " until ", range(acled.data$event_date)[2], ".")) }
           }else{
      stop("The argument 'print.data' requires a logical value.", call. = FALSE)
    }

  return(acled.data)

}

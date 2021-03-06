#' NBA Standings by Date
#'
#' This function the current NBA standings for the given date
#'
#' @param date_string A String of the form "2015-04-01"
#' @return An list containing the standings in the Eastern and Western Conferences
#' @examples
#' NBAStandingsByDate("2010-01-31") # Jan 31, 2010
#' NBAStandingsByDate("2017-11-09") # Nov 09, 2017
#' @export
NBAStandingsByDate <- function(date_string = Sys.Date()){
  date_string <- lubridate::ymd(date_string)
  y <- lubridate::year(date_string)
  m <- lubridate::month(date_string)
  d <- lubridate::day(date_string)
  url <- paste(getOption("NBA_api_base"),
               "/friv/standings.cgi?",
               "month=", m,
               "&day=", d,
               "&year=", y,
               "&lg_id=NBA", sep = "")
  r <- xml2::read_html(url)
  east <- rvest::html_table(r, fill = T)[[1]] %>%
    janitor::clean_names()
  west <- rvest::html_table(r, fill = T)[[2]] %>%
    janitor::clean_names()
  return(list(East = east, West = west))
}

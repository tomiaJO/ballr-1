#' NBA Player Statistics For a Given Season per 100 Possessions
#'
#' This function returns all player statistics per 100 possessions for each
#' player from an NBA season on basketball-reference.com.  See an example
#' table at:
#' https://www.basketball-reference.com/leagues/NBA_2018_per_poss.html
#'
#' @param season A numeric year
#' @return An object of class tbl_df
#'
#' @examples
#' library(magrittr)
#'
#' players <- NBAPerGameStatisticsPer100Poss(season = 2018)
#' players
#'
#' players %>%
#'   dplyr::filter(pos %in% c("SF")) %>%
#'   dplyr::select(player, link) %>%
#'   dplyr::distinct()
#'
#' @export
NBAPerGameStatisticsPer100Poss <- function(season = 2018) {
  nba_url <- paste(getOption("NBA_api_base"),
                   "/leagues/NBA_",
                   season,
                   "_per_poss.html",
                   sep = "")
  pg <- xml2::read_html(nba_url)

  nba_stats <- rvest::html_table(pg, fill = T)[[1]] %>%
    janitor::clean_names() %>%
    dplyr::filter(.data$player != "Player")

  links <- pg %>%
    rvest::html_nodes("tr.full_table") %>%
    rvest::html_nodes("a") %>%
    rvest::html_attr("href")

  link_names <- pg %>%
    rvest::html_nodes("tr.full_table") %>%
    rvest::html_nodes("a") %>%
    rvest::html_text()

  links_df <- dplyr::data_frame(player = as.character(link_names),
                                link   = as.character(links))
  links_df[] <- lapply(links_df, as.character)
  nba_stats <- dplyr::left_join(nba_stats, links_df, by = "player")
  nba_stats <- dplyr::mutate_at(nba_stats,
                                dplyr::vars(-.data$player, -.data$pos, -.data$tm, -.data$link),
                                dplyr::funs(as.numeric))
  return(nba_stats)
}

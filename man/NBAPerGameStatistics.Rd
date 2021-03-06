% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/nba-per-game-stats.R
\name{NBAPerGameStatistics}
\alias{NBAPerGameStatistics}
\title{NBA Player Statistics For a Given Season Per Game}
\usage{
NBAPerGameStatistics(season = 2018)
}
\arguments{
\item{season}{A numeric year}
}
\value{
An object of class \code{\link[dplyr]{tbl_df}}
}
\description{
This function returns all player statistics on a per game basis
from an NBA season on basketball-reference.com.  See an example
table at:
http://www.basketball-reference.com/leagues/NBA_2015_per_game.html
}
\examples{
library(magrittr)

players <- NBAPerGameStatistics(season = 2018)
players

players \%>\%
  dplyr::filter(mp > 20, pos \%in\% c("SF")) \%>\%
  dplyr::select(player, link) \%>\%
  dplyr::distinct()

}

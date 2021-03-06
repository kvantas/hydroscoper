% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/find_stations.R
\name{find_stations}
\alias{find_stations}
\title{Find nearest stations using a point's coordinates}
\usage{
find_stations(longitude = 24, latitude = 38)
}
\arguments{
\item{longitude}{a numeric value in degrees}

\item{latitude}{a numeric value in degrees}
}
\value{
If the given longitude is in [24, 38] and the latitude is in [34, 42]
(i.e. are valid values for Greece) returns an ordered tibble with the
station_id, name, subdomain and distance values in km. The station's data
that are used  come from the `stations` dataset. Otherwise returns an error
message.
}
\description{
\code{find_stations} returns a tibble with the nearest stations'
distances using a given point's longitude and latitude values. This function
uses the Haversine formula for distance calculation in km.
}
\examples{

# find the five nearest stations to a point near Thessaloniki,
# (lon, lat) = (22.97, 40.60)
head(find_stations(22.97, 40.60), 5)
}

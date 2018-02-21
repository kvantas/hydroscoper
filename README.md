hydroscoper
================

<!-- README.md is generated from README.Rmd. Please edit that file -->

[![Travis-CI Build
Status](https://travis-ci.org/kvantas/hydroscoper.svg?branch=master)](https://travis-ci.org/kvantas/hydroscoper)
[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/kvantas/hydroscoper?branch=master&svg=true)](https://ci.appveyor.com/project/kvantas/hydroscoper)
[![codecov](https://codecov.io/github/kvantas/hydroscoper/branch/master/graphs/badge.svg)](https://codecov.io/gh/kvantas/hydroscoper)
[![minimal R
version](https://img.shields.io/badge/R%3E%3D-3.4.0-6666ff.svg)](https://cran.r-project.org/)
[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/hydroscoper)](https://cran.r-project.org/package=hydroscoper)
[![packageversion](https://img.shields.io/badge/Package%20version-0.2.3-orange.svg?style=flat-square)](https://github.com/kvantas/hydroscoper)
[![](https://cranlogs.r-pkg.org/badges/grand-total/hydroscoper)](http://cran.rstudio.com/web/packages/hydroscoper/index.html)
[![ropensci](https://badges.ropensci.org/185_status.svg)](https://github.com/ropensci/onboarding/issues/185)
[![DOI](https://zenodo.org/badge/114094911.svg)](https://zenodo.org/badge/latestdoi/114094911)

<img src="man/figures/hydroscoper_hex.png" align="right" height="220"/>

`hydroscoper` is an R interface to the Greek National Data Bank for
Hydrological and Meteorological Information,
[Hydroscope](http://www.hydroscope.gr/). Hydroscope is the result of
long-standing efforts by numerous Greek scientists in collaboration with
various companies and associations. It was implemented in three phases,
funded by the Ministry of Development, the Ministry of Environment and
Energy and the European Union. 

Hydroscope provides several national data sources from various
organisations via a web interface. Each participating organisation keeps
its data on its own server using the Enhydris database system for the
storage and management of hydrological and meteorological data. These
organisations are:

  - Ministry of Environment and Energy.
  - Ministry of Rural Development and Food.
  - National Meteorological Service.
  - National Observatory of Athens.
  - Greek Prefectures.
  - Public Power Corporation.

The data are structured as tables and space separated text files, but
are in Greek, thus limiting their usefulness. Another issue with
Hydroscope is the lack of comprehensive look-up tables about the
available data, which are spread across many different databases.

`hydroscoper` covers Hydroscopeb s data sources using the Enhydris API.
The Enhydris database is implemented in PostgreSQL and details about the
database can be found [here](http://bit.ly/2D0cZgA), and about the
Web-service API [here](http://bit.ly/2FlRtBB).

`hydroscoper` provides functions to:

1.  Transform the available tables and data sets into tidy data frames
    [(tibbles)](http://tibble.tidyverse.org/).
2.  Transliterate the Greek Unicode text to Latin.
3.  Translate various Greek terms to English.

The internal datasets of the package can be used to run queries on the
available Hydroscopeb s stations and time series data, reducing the time
needed for downloading and [data wrangling](http://bit.ly/1KslZb7), as
these data are rarely modified. These datasets are:

### `stations`

It is a comprehensive look-up table with geographical and ownership
information of the available stations in all Hydroscopeb s databases. The
variables are:

1.  `station_id` The stationb s ID.
2.  `name` The stationb s name.
3.  `water_basin` The stationb s Water Basin.
4.  `water_division` The stationb s Water Division.
5.  `owner` The stationb s owner.
6.  `longitude` The stationb s longitude in decimal degrees,
    [ETRS89](http://bit.ly/2kJwFuf).
7.  `latitude` The stationb s latitude in decimal degrees,
    [ETRS89](http://bit.ly/2kJwFuf).
8.  `altitude` The stationb s altitude, meters above sea level.
9.  `subdomain` The corresponding Hydroscopeb s database.

### `timeseries`

It is also a look-up table with all the available measurements for a
given station in a given Hydroscopeb s database, with units of
measurement and times of those measurements. The variables are:

1.  `time_id` The time series ID.
2.  `station_id` The corresponding stationb s ID.
3.  `variable` The time series variable type.
4.  `timestep` The timestep of time series.
5.  `units` The units of the time series.
6.  `start_date` The starting date of time series values.
7.  `end_date` The ending date of time series values.
8.  `subdomain` The corresponding Hydroscopeb s database.

## Data sources

  - Ministry of Environment and Energy, National Observatory of Athens
    and Greek Prefectures, <http://kyy.hydroscope.gr/>.
  - Ministry of Rural Development and Food,
    <http://ypaat.hydroscope.gr>.
  - National Meteorological Service, <http://emy.hydroscope.gr>.
  - Greek Public Power Corporation, <http://deh.hydroscope.gr>.

Note that:

1.  Only the two Ministries allow to download time series values freely.
2.  `ypaat`, `emy` and `kyy` sub domains are maintained by the National
    Technical University Of Athens and these servers work seamlessly.
3.  `deh` sub domain is maintained by the Greek Public Power
    Corporation, uses an older version of the Enhydris API and
    occasionally the server is down.

## Installation

Install the stable release from CRAN with:

``` r
install.packages("hydroscoper")
```

You can install the development version from GitHub with:

``` r
# install.packages("devtools")
devtools::install_github("kvantas/hydroscoper")
```

## Using hydroscoper

The functions that are provided by `hydroscoper` are:

  - `get_stations, get_timeseries, get_instruments, get_water_basins,
    get_water_divisions, get_political_divisions, get_variables,
    get_units_of_measurement, get_time_steps, get_owners,
    get_instruments_type, get_station_type, get_database` family
    functions, to retrieve tibbles with Hydroscopeb s data for a given
    data source.
  - `get_data`, to retrieve a tibble with time seriesb  values.  
  - `hydro_coords`, to convert Hydroscopeb s pointsb  raw format to a
    tibble.
  - `hydro_translate` to translate various terms and names from Greek to
    English.

The data sets that are provided by `hydroscoper` are:

  - `stations` a tibble with stationsb  data from Hydroscope.
  - `timeseries` a tibble with time seriesb  data from Hydroscope.
  - `greece_borders` a tibble with the borders of Greece.

## Example

This is a basic example which shows how to get the stationsb  and time
seriesb  data from the Hydroscopeb s Ministry of Environment and Energy
database, <http://kyy.hydroscope.gr/>.

Load libraries:

``` r
library(hydroscoper)
library(tibble)
```

We will use the packageb s data `stations` and `timeseries`, to reduce
the time needed with data munging. We can subset the stationb s data for
the `kyy` sub-domain with:

``` r

# load data
data("stations")

# subset stations data
kyy_stations <- subset(stations, subdomain == "kyy")

# view kyy stations
kyy_stations
#> # A tibble: 425 x 9
#>    station_id name    water_basin  water_division owner longitude latitude
#>         <int> <chr>   <chr>        <chr>          <chr>     <dbl>    <dbl>
#>  1     501032 AG. BA~ "KOURTALIOT~ GR13           min_~      NA       NA  
#>  2     200246 GEPH. ~ "ALPHEIOS P~ GR01           min_~      22.0     37.5
#>  3     200237 TROPAIA "ALPHEIOS P~ GR01           min_~      22.0     37.7
#>  4     200231 BYTINA  "ALPHEIOS P~ GR01           min_~      22.2     37.7
#>  5     200200 LYKOUR~ "ALPHEIOS P~ GR01           min_~      22.2     37.9
#>  6     200236 MEGALO~ "ALPHEIOS P~ GR01           min_~      22.1     37.4
#>  7     200244 ODOG. ~ "REMA CHORA~ GR01           min_~      21.8     37.0
#>  8     200204 TRIPOT~ "ALPHEIOS P~ GR01           min_~      21.9     37.9
#>  9     200198 KASTEL~ "ALPHEIOS P~ GR01           min_~      22.0     37.9
#> 10     200239 PERDIK~ "ALPHEIOS P~ GR01           min_~      22.0     37.7
#> # ... with 415 more rows, and 2 more variables: altitude <dbl>,
#> #   subdomain <chr>
```

To get the time seriesb  data for the station `200200`
(<http://kyy.hydroscope.gr/stations/d/200200/>) we can use:

``` r
station_ts <- subset(timeseries, station_id == 200200)
station_ts
#> # A tibble: 4 x 8
#>   time_id station_id variable timestep units start_date end_date subdomain
#>     <int>      <int> <chr>    <chr>    <chr> <chr>      <chr>    <chr>    
#> 1     761     200200 wind_di~ <NA>     B0     1948-01-0~ 1997-07~ kyy      
#> 2      56     200200 precipi~ 30_minu~ mm    1985-05-0~ 1997-01~ kyy      
#> 3     760     200200 snow     daily    mm    1948-01-0~ 1997-07~ kyy      
#> 4     759     200200 precipi~ daily    mm    1953-03-0~ 2011-06~ kyy
```

We can download the stationb s precipitation time series **56**
(<http://kyy.hydroscope.gr/timeseries/d/56/>):

``` r
ts_raw <- get_data(subdomain = "kyy", time_id = 56)
ts_raw
#> # A tibble: 147,519 x 3
#>    date                value comment
#>    <dttm>              <dbl> <chr>  
#>  1 1985-05-06 08:00:00     0 1      
#>  2 1985-05-06 08:30:00     0 1      
#>  3 1985-05-06 09:00:00     0 1      
#>  4 1985-05-06 09:30:00     0 1      
#>  5 1985-05-06 10:00:00     0 1      
#>  6 1985-05-06 10:30:00     0 1      
#>  7 1985-05-06 11:00:00     0 1      
#>  8 1985-05-06 11:30:00     0 1      
#>  9 1985-05-06 12:00:00     0 1      
#> 10 1985-05-06 12:30:00     0 1      
#> # ... with 147,509 more rows
```

Letb s create a plot:

``` r
library(ggplot2)
ggplot(data = ts_raw, aes(x = date, y = value))+
  geom_line()+
  labs(title= "30 min precipitation for station 200200",
       x="Date", y = "Rain height (mm)")+
  theme_classic()
```

![](man/figures/README-plot_time_series-1.png)<!-- -->

## Meta

  - Bug reports, suggestions, and code are welcome. Please see
    [Contributing](/CONTRIBUTING.md). By participating in this project
    you agree to abide by the terms in [Contributor Code of
    Conduct](/CONDUCT.md).

  - Licence:
    
      - All code is licensed MIT.
      - All data are from the public data sources in
        <http://www.hydroscope.gr/>.

  - To cite `hydroscoper`, please
        use:
    
        Konstantinos Vantas (2017). hydroscoper: Interface to Hydroscope, R package version 0.1.0, URL http://CRAN.R-project.org/package=hydroscoper
    
    A BibTeX entry for LaTeX users is
    
    ``` 
     @Manual{,
      title = {hydroscoper: Interface to Hydroscope},
      author = {Konstantinos Vantas},
      year = {2017},
      note = {R package version 0.1.0},
      url = {http://CRAN.R-project.org/package=hydroscoper},
    }
    ```

## References

[Hydroscope](http://www.hydroscope.gr/)

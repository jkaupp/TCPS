% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plots.R
\name{tcps_lever_ridgeline}
\alias{tcps_lever_ridgeline}
\title{Visualize TCPS lever data as a ridline plot contrasting agreement and importance}
\usage{
tcps_lever_ridgeline(
  x,
  name = "University Name",
  lever = NULL,
  pal = pal_one,
  aggregate = FALSE
)
}
\arguments{
\item{x}{input tidy TCPS data frame}

\item{name}{name of institution}

\item{lever}{short name of the lever of interest}

\item{pal}{a simple two color palette for agreement/importance in the plot.}

\item{aggregate}{TRUE/FALSE.  If TRUE, aggregate responses across all populations (surveys) in the data frame}
}
\value{
a nifty plot!
}
\description{
Visualize TCPS lever data as a ridline plot contrasting agreement and importance
}

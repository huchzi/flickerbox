% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/shiftConeFundamentals.R
\name{shiftConeFundamentals}
\alias{shiftConeFundamentals}
\title{Shifts the cone fundamentals of a given photoreceptor by a multiple of two}
\usage{
shiftConeFundamentals(ConeFund, receptor, dlambda)
}
\arguments{
\item{ConeFund}{the original cone fundamentals}

\item{receptor}{the affected photoreceptor type}

\item{dlambda}{the magnitude of the shift; must be a multiple of two}
}
\value{
returns new cone fundamentals
}
\description{
Polymorphisms in the cone opsin genes can lead to a shift in the cone fundamentals of the affected photoreceptor. There are no known polymorphisms for rhodopsin, but the L-cone opsin is frequently affected. This function can be used to simulate such polymorphisms.
}

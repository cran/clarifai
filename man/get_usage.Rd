% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_usage.R
\name{get_usage}
\alias{get_usage}
\title{Get API usage for the current month and hour}
\usage{
get_usage(...)
}
\arguments{
\item{\dots}{Additional arguments passed to \code{\link{clarifai_GET}}.}
}
\value{
named list with four items \code{status_code}, \code{status_msg}, \code{results} (user and application details --- credits consumed, total credit)
}
\description{
Get API usage for the current month and hour
}
\examples{
\dontrun{

# Before calling the function, set API secret and id via secret_id(c("client_id", "secret")) 
# and get token via get_token()

get_usage()
}
}
\references{
\url{https://developer.clarifai.com/}
}

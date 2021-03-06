% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_color.R
\name{get_color}
\alias{get_color}
\title{Get the dominant colors present in images or videos}
\usage{
get_color(file_paths = NULL, ...)
}
\arguments{
\item{file_paths}{a vactor of paths to image file(s) for which you want tags}

\item{\dots}{Additional arguments passed to \code{\link{clarifai_POST}}.}
}
\value{
Named list of length 3: \code{status_code}, \code{status_msg}, and \code{results}. 
\code{results} is a named list of length 12. Contains information about max. and 
min. image and video size allowed etc. 

Prints \code{status_msg} by default
}
\description{
Get the dominant colors present in images or videos
}
\examples{
\dontrun{

# Before calling the function, set API secret and id via secret_id(c("client_id", "secret")) 
# and get token via get_token()

get_color(file_paths="path_to_image")
}
}
\references{
\url{https://developer.clarifai.com/}
}

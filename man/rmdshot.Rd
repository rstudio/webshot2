% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rmdshot.R
\name{rmdshot}
\alias{rmdshot}
\title{Take a snapshot of an R Markdown document}
\usage{
rmdshot(
  doc,
  file = "webshot.png",
  ...,
  delay = NULL,
  rmd_args = list(),
  port = getOption("shiny.port"),
  envvars = NULL
)
}
\arguments{
\item{doc}{The path to a Rmd document.}

\item{file}{A vector of names of output files. Should end with an image file
type (\code{.png}, \code{.jpg}, \code{.jpeg}, or \code{.webp}) or
\code{.pdf}. If several screenshots have to be taken and only one filename
is provided, then the function appends the index number of the screenshot
to the file name. For PDF output, it is just like printing the page to PDF
in a browser; \code{selector}, \code{cliprect}, \code{expand}, and
\code{zoom} will not be used for PDFs.}

\item{...}{Other arguments to pass on to \code{\link[=webshot]{webshot()}}.}

\item{delay}{Time to wait before taking screenshot, in seconds. Sometimes a
longer delay is needed for all assets to display properly. If NULL (the
default), then it will use 0.2 seconds for static Rmd documents, and 3
seconds for Rmd documents with runtime:shiny.}

\item{rmd_args}{A list of additional arguments to pass to either
\code{\link[rmarkdown:render]{rmarkdown::render()}} (for static Rmd documents) or
\code{\link[rmarkdown:run]{rmarkdown::run()}} (for Rmd documents with runtime:shiny).}

\item{port}{Port that Shiny will listen on.}

\item{envvars}{A named character vector or named list of environment
variables and values to set for the Shiny app's R process. These will be
unset after the process exits. This can be used to pass configuration
information to a Shiny app.}
}
\value{
Invisibly returns the normalized path to all screenshots taken. The
character vector will have a class of \code{"webshot"}.
}
\description{
This function can handle both static Rmd documents and Rmd documents with
\code{runtime: shiny}.
}
\examples{
if (interactive()) {
  # R Markdown file
  input_file <- system.file("examples/knitr-minimal.Rmd", package = "knitr")
  rmdshot(input_file, "minimal_rmd.png")

  # Shiny R Markdown file
  input_file <- system.file("examples/shiny.Rmd", package = "webshot")
  rmdshot(input_file, "shiny_rmd.png", delay = 5)
}

}

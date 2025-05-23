% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/appshot.R
\name{appshot}
\alias{appshot}
\alias{appshot.character}
\alias{appshot.shiny.appobj}
\title{Take a screenshot of a Shiny app}
\usage{
appshot(
  app,
  file = "webshot.png",
  ...,
  port = getOption("shiny.port"),
  envvars = NULL
)

\method{appshot}{character}(
  app,
  file = "webshot.png",
  ...,
  port = getOption("shiny.port"),
  envvars = NULL
)

\method{appshot}{shiny.appobj}(
  app,
  file = "webshot.png",
  ...,
  port = getOption("shiny.port"),
  envvars = NULL,
  webshot_timeout = 60
)
}
\arguments{
\item{app}{A Shiny app object, or a string naming an app directory.}

\item{file}{A vector of names of output files. Should end with an image file
type (\code{.png}, \code{.jpg}, \code{.jpeg}, or \code{.webp}) or
\code{.pdf}. If several screenshots have to be taken and only one filename
is provided, then the function appends the index number of the screenshot
to the file name. For PDF output, it is just like printing the page to PDF
in a browser; \code{selector}, \code{cliprect}, \code{expand}, and
\code{zoom} will not be used for PDFs.}

\item{...}{Other arguments to pass on to \code{\link[=webshot]{webshot()}}.}

\item{port}{Port that Shiny will listen on.}

\item{envvars}{A named character vector or named list of environment
variables and values to set for the Shiny app's R process. These will be
unset after the process exits. This can be used to pass configuration
information to a Shiny app.}

\item{webshot_timeout}{The maximum number of seconds the phantom application
is allowed to run before killing the process. If a delay argument is
supplied (in \code{...}), the delay value is added to the timeout value.}
}
\value{
Invisibly returns the normalized path to all screenshots taken. The
character vector will have a class of \code{"webshot"}.
}
\description{
\code{appshot} performs a \code{\link[=webshot]{webshot()}} using two different methods
depending upon the object provided.

If a string is provided (pointing to an `app.R`` file or app directory) an
isolated background R process is launched to run the Shiny application. The
current R process then captures the \code{\link[=webshot]{webshot()}}.

When a Shiny application object is supplied to \code{appshot}, it is reversed: the
Shiny application runs in the current R process and an isolated background R
process is launched to capture a \code{\link[=webshot]{webshot()}}. The reason it is reversed in
the second case has to do with scoping: although it would be preferable to
run the Shiny application in a background process and call \code{webshot} from the
current process, with Shiny application objects, there are potential scoping
errors when run this way.
}
\examples{
if (interactive()) {
  appdir <- system.file("examples", "01_hello", package="shiny")

  # With a Shiny directory
  appshot(appdir, "01_hello.png")

  # With a Shiny App object
  shinyapp <- shiny::shinyAppDir(appdir)
  appshot(shinyapp, "01_hello_app.png")
}

}

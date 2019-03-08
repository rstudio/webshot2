#' @import chromote
#' @import later
#' @import promises
#'
NULL


#' @export
webshot <- function(
  url = NULL,
  file = "webshot.png",
  vwidth = 992,
  vheight = 744,
  cliprect = NULL,
  selector = NULL,
  expand = NULL,
  delay = 0.2,
  zoom = 1,
  eval = NULL,
  debug = FALSE,
  useragent = NULL
) {

  if (length(url) == 0) {
    stop("Need url.")
  }

  # If user provides only one file name but wants several screenshots, then the
  # below code generates as many file names as URLs following the pattern
  # "filename001.png", "filename002.png", ... (or whatever extension it is)
  if (length(url) > 1 && length(file) == 1) {
    file <- vapply(1:length(url), FUN.VALUE = character(1), function(i) {
      replacement <- sprintf("%03d.\\1", i)
      gsub("\\.(.{3,4})$", replacement, file)
    })
  }

  cm <- ChromoteMaster$new()

  # A list of promises for the screenshots
  res <- mapply(url, file, FUN = function(url, file) {
    new_session_screenshot(cm, url, file)
  }, SIMPLIFY = FALSE)


  p <- promise_all(.list = res)
  cm$wait_for(p)
}


new_session_screenshot <- function(chromote_master, url, filename) {
  s <- NULL

  p <- chromote_master$new_session(sync_ = FALSE)
  p$then(function(session) {
      s <<- session
      s$Page$navigate(url, sync_ = FALSE)
      s$Page$loadEventFired(sync_ = FALSE)
    })$
    then(function(value) {
      message(url, " loaded")
      s$screenshot(filename = file, show = FALSE, scale = 0.5, sync_ = FALSE)
    })$
    then(function(value) {
      message(url, " screenshot completed")
      value
    })$
    finally(function() {
      s$close()
    })
}

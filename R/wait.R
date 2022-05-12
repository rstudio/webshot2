shiny_url <- function(port) {
  sprintf("http://127.0.0.1:%d/", port)
}

server_exists <- function(url_id) {
  # Using a url object instead of the url as a string because readLines() with
  # url string will cause failed connections to stay open
  url_obj <- url(url_id)
  on.exit({close(url_obj)}, add = TRUE)

  ret <- !inherits(
    try({suppressWarnings(readLines(url_obj, 1))}, silent = TRUE),
    "try-error"
  )
  ret
}

webshot_app_timeout <- function() {
  getOption("webshot.app.timeout", 60)
}

wait_until_server_exists <- function(
  url,
  p,
  timeout = webshot_app_timeout()
) {
  cur_time <- function() {
    as.numeric(Sys.time())
  }
  start <- cur_time()
  while (!server_exists(url)) {
    if (cur_time() - start > timeout) {
      stop(
        "It took more than ", timeout,
        " seconds to launch the Shiny Application. ",
        "There may be something wrong. The process has been killed. ",
        "If the app needs more time to be launched, set ",
        "options(webshot.app.timeout) to a larger value.",
        call. = FALSE
      )
    }

    # Check if there was a failure in starting app server
    if (!p$is_alive()) {
      stop(
        "App has failed with error(s):\n",
        paste(p$read_error_lines(), collapse = "\n"),
        call. = FALSE
      )
    }

    Sys.sleep(0.25)
  }

  TRUE
}

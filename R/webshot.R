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
  debug = FALSE,
  useragent = NULL
) {

  if (length(url) == 0) {
    stop("Need url.")
  }

  # Convert params cliprect, selector and expand to list if necessary
  if(!is.null(cliprect) && !is.list(cliprect)) cliprect <- list(cliprect)
  if(!is.null(selector) && !is.list(selector)) selector <- list(selector)
  if(!is.null(expand)   && !is.list(expand))   expand   <- list(expand)

  # If user provides only one file name but wants several screenshots, then the
  # below code generates as many file names as URLs following the pattern
  # "filename001.png", "filename002.png", ... (or whatever extension it is)
  if (length(url) > 1 && length(file) == 1) {
    file <- vapply(1:length(url), FUN.VALUE = character(1), function(i) {
      replacement <- sprintf("%03d.\\1", i)
      gsub("\\.(.{3,4})$", replacement, file)
    })
  }

  if (!is.null(cliprect) && !is.null(selector)) {
    stop("Can't specify both cliprect and selector.")

  } else if (is.null(selector) && !is.null(cliprect)) {
    cliprect <- lapply(cliprect, function(x) {
      if (is.character(x)) {
        if (x == "viewport") {
          x <- c(0, 0, vwidth, vheight)
        } else {
          stop("Invalid value for cliprect: ", x)
        }
      } else {
        if (!is.numeric(x) || length(x) != 4) {
          stop("'cliprect' must be a vector with four numbers, or a list of such vectors")
        }
      }
      x
    })
  }

  # Check length of arguments and replicate if necessary
  args_all <- list(
    url      = url,
    file     = file,
    vwidth   = vwidth,
    vheight  = vheight,
    cliprect = cliprect,
    selector = selector,
    expand   = expand,
    delay    = delay,
    zoom     = zoom,
    debug    = debug
  )

  n_urls <- length(url)
  args_all <- mapply(args_all, names(args_all),
    FUN = function(arg, name) {
      if (length(arg) == 0) {
        return(vector(mode = "list", n_urls))
      } else if (length(arg) == 1) {
        return(rep(arg, n_urls))
      } else if (length(arg) == n_urls) {
        return(arg)
      } else {
        stop("Argument `", name, "` should be NULL, length 1, or same length as `url`.")
      }
    },
    SIMPLIFY = FALSE
  )

  args_all <- long_to_wide(args_all)

  cm <- ChromoteMaster$new()

  # A list of promises for the screenshots
  res <- lapply(args_all,
    function(args) {
      new_session_screenshot(cm,
        args$url, args$file, args$vwidth, args$vheight, args$cliprect,
        args$selector, args$expand, args$delay, args$zoom
      )
    }
  )

  p <- promise_all(.list = res)
  invisible(cm$wait_for(p))
}


new_session_screenshot <- function(
  chromote_master,
  url,
  file,
  vwidth,
  vheight,
  cliprect,
  selector,
  expand,
  delay,
  zoom
) {
  s <- NULL

  p <- chromote_master$new_session(sync_ = FALSE,
      width = vwidth,
      height = vheight
    )$
    then(function(session) {
      s <<- session
      s$Page$navigate(url, sync_ = FALSE)
      s$Page$loadEventFired(sync_ = FALSE)
    })$
    then(function(value) {
      if (delay > 0) {
        promise(function(resolve, reject) {
          later(
            function() {
              resolve(value)
            },
            delay
          )
        })
      } else {
        value
      }
    })$
    then(function(value) {
      s$screenshot(filename = file, show = FALSE, scale = 0.5, sync_ = FALSE)
    })$
    then(function(value) {
      message(url, " screenshot completed")
      value
    })$
    finally(function() {
      s$close()
    })

  p
}

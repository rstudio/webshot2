# =============================================================================
# System
# =============================================================================

is_windows <- function() .Platform$OS.type == "windows"

is_mac <- function() Sys.info()[["sysname"]] == "Darwin"

is_linux <- function() Sys.info()[["sysname"]] == "Linux"



# =============================================================================
# Data manipulation
# =============================================================================

# Convert a list of vectors of the same length (like a data frame) to a list of
# lists, each of which is a one-row "slice" of the input (like a D3 data
# structure). The input list must be named, and the names must be unique.
long_to_wide <- function(x) {
  if (length(x) == 0)
    return(x)

  lapply(seq_along(x[[1]]), function(n) {
    lapply(stats::setNames(names(x), names(x)), function(name) {
      x[[name]][[n]]
    })
  })
}


# =============================================================================
# Network-related stuff
# =============================================================================

# Find an available TCP port (to launch Shiny apps)
available_port <- function(port = NULL, min = 3000, max = 9000) {
  if (!is.null(port)) return(port)

  # Unsafe port list from shiny::runApp()
  valid_ports <- setdiff(min:max, c(3659, 4045, 6000, 6665:6669, 6697))

  # Try up to 20 ports
  for (port in sample(valid_ports, 20)) {
    handle <- NULL

    # Check if port is open
    tryCatch(
      handle <- httpuv::startServer("127.0.0.1", port, list()),
      error = function(e) { }
    )
    if (!is.null(handle)) {
      handle$stop()
      return(port)
    }
  }

  stop("Cannot find an available port")
}


# Returns TRUE if a string is a URL (of form "http://...", "ftp://...",
# "file://..." and so on), FALSE otherwise.
is_url <- function(x) {
  grepl("^[a-zA-Z]+://", x)
}

# Given the path to a file, return a file:// URL.
file_url <- function(filename) {
  if (is_windows()) {
    paste0("file://", normalizePath(filename, mustWork = TRUE))
  } else {
    enc2utf8(paste0("file:///", normalizePath(filename, winslash = "/", mustWork = TRUE)))
  }
}

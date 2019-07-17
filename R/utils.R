# Convert a list of vectors of the same length (like a data frame) to a list of
# lists, each of which is a one-row "slice" of the input (like a D3 data
# structure). The input list must be named, and the names must be unique.
long_to_wide <- function(x) {
  if (length(x) == 0)
    return(x)

  lapply(seq_along(x[[1]]), function(n) {
    lapply(setNames(names(x), names(x)), function(name) {
      x[[name]][[n]]
    })
  })
}

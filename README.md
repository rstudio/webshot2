webshot2
========

**webshot2** is meant to be a replacement for [webshot](https://wch.github.io/webshot/), except that instead of using PhantomJS, it uses headless Chrome.


## Installation

webshot2 currently depends on a number of in-development packages.

```R
devtools::install_github(c(
  "r-lib/later@joe/feature/private-event-loops2",
  "rstudio/websocket",
  "rstudio/chromote"
))
```


## Usage

```R
library(webshot2)

# Single page
webshot("https://www.r-project.org")

# Multiple pages (in parallel!)
webshot(c("https://www.r-project.org", "https://www.rstudio.com"))
```

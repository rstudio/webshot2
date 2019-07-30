webshot2
========

**webshot2** is meant to be a replacement for [webshot](https://wch.github.io/webshot/), except that instead of using PhantomJS, it uses headless Chrome via the [Chromote](https://github.com/rstudio/chromote) package


## Installation

webshot2 currently depends on a number of in-development packages.

```R
devtools::install_github("rstudio/webshot2")
```

You also need to have the Chrome browser installed on your system. You can also use other browsers based on Chromium, such as Chromium itself, Edge, Vivaldi, Brave, or Opera.


## Usage

```R
library(webshot2)

# Single page
webshot("https://www.r-project.org")

# Multiple pages (in parallel!)
webshot(c("https://www.r-project.org", "https://www.rstudio.com"))
```

# webshot2 (development version)

* `webshot()` now rounds `vwidth` and `vheight` to the nearest integer to match Chrome's expectations. If this behavior is somehow problematic, you can use `vwidth = I(my_width)` to avoid the conversion. (#70)

# webshot2 0.1.1

* `webshot()` now supports JPEG (`.jpg` or `.jpeg`) and WEBP (`.webp`) image formats. (@trafficonese #45)

* Fixed #52: `rmdshot()` did not work when used to screenshot an R Markdown document with `runtime: shiny` or `runtime: shinyrmd`. (#53)

* Fixed #24: Console messages from `webshot()` can now be suppressed by setting `quiet = TRUE` or using the `webshot.quiet` global option. (@trafficonese #45)

# webshot2 0.1.0

* Added a `NEWS.md` file to track changes to the package.

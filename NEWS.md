# webshot2 (development version)

* Migrate GPL-2 license to MIT (#79)

* Updated the documentation for `webshot()` to clarify that `expand` only applies to the clipping rectangle determined by `selector`. (#68)

* `webshot()` now rounds `vwidth` and `vheight` to the nearest integer to match Chrome's expectations. If this behavior is somehow problematic, you can use `vwidth = I(my_width)` to avoid the conversion. (#70)

* `webshot()` now surfaces errors that occur when working with the lower-level screenshot API provided by Chrome via `{chromote}`. (#69)

* `webshot()` works harder to set the size of the virtual viewport when `vwidth` and `vheight` are used. This change improves compatibility with recent versions of Chrome (>= v132). (#72)

# webshot2 0.1.1

* `webshot()` now supports JPEG (`.jpg` or `.jpeg`) and WEBP (`.webp`) image formats. (@trafficonese #45)

* Fixed #52: `rmdshot()` did not work when used to screenshot an R Markdown document with `runtime: shiny` or `runtime: shinyrmd`. (#53)

* Fixed #24: Console messages from `webshot()` can now be suppressed by setting `quiet = TRUE` or using the `webshot.quiet` global option. (@trafficonese #45)

# webshot2 0.1.0

* Added a `NEWS.md` file to track changes to the package.

## Comments

#### 2022-05-13

Updates:
* I have added `\value` docs for all five methods.
* I have removed the commented code in the example of `rmdshot.Rd`

Thank you,
Winston


#### 2022-05-13

Thanks,

Please add \value to .Rd files regarding exported methods and explain
the functions results in the documentation. Please write about the
structure of the output (class) and also what the output means. (If a
function does not return a value, please document that too, e.g.
\value{No return value, called for side effects} or similar)
Missing Rd-tags:
      appshot.Rd: \value
      resize.Rd: \value
      rmdshot.Rd: \value
      shrink.Rd: \value
      webshot.Rd: \value

Some code lines in examples are commented out in rmdshot.Rd
Please never do that. Ideally find toy examples that can be regularly
executed and checked. Lengthy examples (> 5 sec), can be wrapped in
\donttest{}.
If you use external software for examples, please wrap them in
\dontrun{} instead.

Please fix and resubmit.

Best,
Victoria Wimmer

#### 2022-05-12

Releasing a new package `{webshot2}`.

The invalid url to https://www.r-pkg.org/pkg/webshot2 should work once the package is on CRAN.

Please let me know if there is any more information I can provide.

Thank you,
Winston


## Test environments

* local macOS, R 4.1.3
* GitHub Actions
  * macOS
    * 4.2
  * windows
    * 4.2
  * ubuntu18
    * devel, 4.2, 4.1, 4.0, 3.6, 3.5
* devtools::
  * check_win_devel()
  * check_win_release()
  * check_win_oldrelease()

## R CMD check results

0 errors ✔ | 0 warnings ✔ | 1 note

N  checking CRAN incoming feasibility
   Maintainer: ‘Winston Chang <winston@rstudio.com>’

   New submission

  Found the following (possibly) invalid URLs:
    URL: https://www.r-pkg.org/pkg/webshot2
      From: README.md
      Status: 500
      Message: Internal Server Error

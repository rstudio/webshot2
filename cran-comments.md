## Comments
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

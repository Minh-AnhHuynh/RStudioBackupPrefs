
<!-- README.md is generated from README.Rmd. Please edit that file -->

# RStudioBackupPrefs

<!-- badges: start -->

[![R-CMD-check](https://github.com/Minh-AnhHuynh/RStudioBackupPrefs/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/Minh-AnhHuynh/RStudioBackupPrefs/actions/workflows/R-CMD-check.yaml)

<!-- badges: end -->

The goal of RStudioBackupPrefs is to provide an easy and online way to
backup and restore your R Studio preferences. For reference, the
following files are backed up :

- `addins.json`

- `rstudio_bindings.json`

- `rstudio-prefs.json`

- `r.snippets`

Credits to
[pat-s/rstudioSettings](https://github.com/pat-s/rstudioSettings.git)
for the idea and getting inspiration from the backup code.

## Installation

You can install the development version of RStudioBackupPrefs from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("Minh-AnhHuynh/RStudioBackupPrefs")
```

Additionally I am fond of the `librarian` package, you can install the
package with:

``` r
# install.packages("librarian") 

# librarian::shelf() will install or load the package if already installed.
# You can queue up multiple package in one line.

librarian::shelf(Minh-AnhHuynh/RStudioBackupPrefs)
```

## Example

This is a basic example which shows you how to use the package:

``` r
# Backup your preferences
library(RStudioBackupPrefs)
start_backup_prefs(github_backup = TRUE)


# Import your preferences
start_import_prefs(pull_github = TRUE, clone_git = FALSE)

# Use clone_git = TRUE for first time usage
start_import_prefs(clone_git = TRUE)
```

To use the GitHub functionalities, you need to have an initiated
repository. Simply initiate one with :

``` r
# Assuming you're in a folder:
usethis::use_git()
usethis::use_github()

# Optional:
usethis::git_vaccinate()

# Set your credentials if needed:
gitcreds::gitcreds_set()
```

Make sure to put your user.name and user.email in global config. To do
so, go to Terminal and write :

``` powershell
git init
git config --global user.name "YOUR FULL NAME"
git config --global user.email "YOUR EMAIL ADDRESS"
```

<!-- You'll still need to render `README.Rmd` regularly, to keep `README.md` up-to-date. `devtools::build_readme()` is handy for this. You could also use GitHub Actions to re-render `README.Rmd` every time you push. An example workflow can be found here: <https://github.com/r-lib/actions/tree/v1/examples>. -->

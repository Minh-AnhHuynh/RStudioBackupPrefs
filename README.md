
<!-- badges: start -->

[![R-CMD-check](https://github.com/Minh-AnhHuynh/RStudioBackupPrefs/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/Minh-AnhHuynh/RStudioBackupPrefs/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/Minh-AnhHuynh/RStudioBackupPrefs/branch/main/graph/badge.svg)](https://app.codecov.io/gh/Minh-AnhHuynh/RStudioBackupPrefs?branch=main)

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

# Installation

You can install the development version of RStudioBackupPrefs from
[GitHub](https://github.com/) with:

``` r
install.packages("devtools")
devtools::install_github("Minh-AnhHuynh/RStudioBackupPrefs")

# Alternatively
install.packages("librarian") 
librarian::shelf("Minh-AnhHuynh/RStudioBackupPrefs")

# librarian::shelf() will install or load the package if already installed.
# You can queue up multiple package in one line.
```

# Quick Start

The idea is to install this package on a new R project or machine,
import your preferences from Github by first cloning the repository
containing your rstudio preference files and copying them to the
relevant rstudio preference folder.

For backing up, the idea is to upload your current RStudio settings to
the currently git initiated repository, or to choose a dedicated git
repository for your RStudio settings.

## Upload preferences to Github

``` r
library(RStudioBackupPrefs)
start_backup_prefs(github_backup = TRUE)
```

Back up using a specific folder containing your preference files. If
inside an R project, you’d want to specify the path to the R folder that
is outside of your current one (else it’s the same as the current one)

``` r
start_backup_prefs(github_backup = TRUE, repository = "../MyRStudioPrefs")
```

## Import preferences from Github

In any case, the function will **copy the files** to the rstudio
preference folder (import), refresh with `F10`.

### You have a new R project and want to import your preferences from Github

You are required to clone the repository containing your preferences
first. For convenience you can clone a github folder and copy with the
same function.

Use `clone_git = TRUE`, the function will ask for the git url

``` r
start_import_prefs(clone_git = TRUE)
```

You can specify the git url directly

``` r
start_import_prefs(clone_git = TRUE, git_url = "https://github.com/cran/dummies")
```

### You are in the R project containing your preference files, but you want to pull

``` r
start_import_prefs(pull_git = TRUE)
```

### Your files are already in your current project, specify your path

``` r
start_import_prefs("R/rstudio_preferences/")
```

## Offline backup

``` r
# Choose a path
start_backup_prefs(preference_path = "R/rstudio_preferences", copy_to_local = TRUE) 

# If you are fine with leaving files in your R Studio preference folder
start_backup_prefs()

# Use open_backup_path = TRUE to see your files in the explorer
start_backup_prefs(open_backup_path = TRUE)
```

Use `start_import_prefs()` to import your preferences from the local
folder.

# Github setup

To use the GitHub functionalities, you need to have an initiated
repository. Simply initiate one with:

``` r
# Assuming you're in your desired folder path:
usethis::use_git()
usethis::use_github()

# Optional:
usethis::git_vaccinate()

# Set your credentials if needed:
gitcreds::gitcreds_set()
```

Make sure to put your user.name and user.email in global config. To do
so, go to Terminal and write:

``` powershell
git init
git config --global user.name "YOUR FULL NAME"
git config --global user.email "YOUR EMAIL ADDRESS"
```

Check out [Happy Git with R](https://happygitwithr.com/) for more
information.

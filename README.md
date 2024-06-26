
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
import your preferences from GitHub by first cloning the repository
containing your rstudio preference files and copying them to the
relevant RStudio preference folder.

For backing up, the idea is to upload your current RStudio settings to
the currently git initiated repository, or to choose a dedicated git
repository for your RStudio settings and thus another folder on your
local machine.

## Upload preferences to GitHub

``` r
library(RStudioBackupPrefs)
start_backup_prefs(github_backup = TRUE)
```

Back up using a specific folder containing your preference files. If
your working directory is currently inside an R project, you’d want to
specify the path to the R folder that is outside of your current one
(else it’s the same as the current one)

``` r
start_backup_prefs(github_backup = TRUE, repository = "../MyRStudioPrefs")
```

## Import preferences from GitHub

The function will pull from GitHub by default, and will to **copy the
files** to the rstudio preference folder (import).

Note that you have to specify the folder where our RStudio preference
files are backed up, which should be in the same folder, obtained
through the `start_backup_prefs()` function. For example,
`start_backup_prefs(preference_path = "R/rstudio_preferences")` will
create a folder named `R/rstudio_preferences/` in the current working
directory.

### You have a new R project and want to import your preferences from GitHub

You are required to clone the repository containing your preferences
first. For convenience you can clone a GitHub folder and copy with the
same function.

Use `clone_git = TRUE`, the function will ask for the git url and list
the GitHub repositories under the current git username

``` r
start_import_prefs(clone_git = TRUE)
```

You can specify the git url directly. Use `list_github_repositories()`
to list the repositories under your current git username.

``` r
list_github_repositories()
start_import_prefs(clone_git = TRUE, git_url = "https://github.com/cran/dummies")
```

Specify the clone path if you want to clone to a specific folder.

``` r
start_import_prefs(clone_git = TRUE, git_path = "../MyRStudioPrefs")
```

### You already have a Git repository cloned

#### Pull from Github and Import

``` r
start_import_prefs(preference_path = "R/rstudio_preferences/")
```

#### Your files are in a different R Project/Git folder

`git pull` will work inside a git folder regardless of the file path.

``` r
start_import_prefs("../MyRStudioPrefs/R/rstudio_preferences/")
```

#### Your files are already in your current project, specify your path

``` r
start_import_prefs(preference_path = "R/rstudio_preferences/", pull_github = FALSE)
```

## Offline backup

``` r
# Choose a path
start_backup_prefs(preference_path = "R/rstudio_preferences", copy_to_local = TRUE) 

# If you are fine with leaving files in your RStudio preference folder
start_backup_prefs()

# Use open_backup_path = TRUE to see the RStudio preference folder
start_backup_prefs(open_backup_path = TRUE)
```

Use `start_import_prefs(pull_github = FALSE)` to import your preferences
from the local folder.

# GitHub setup

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

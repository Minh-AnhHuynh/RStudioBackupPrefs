#' Start the import process from Github by default or your local json preference files
#'
#' Import preferences by cloning a link or pulling from your GitHub. The
#' function will start to pull from the currently active GitHub repository, then will import the local .json
#' preference files. The function will look for the specific .json files only, in the given file path.
#'
#' @seealso [import_from_github()] to just import, and [import_local_prefs()] to import locally
#' @details Function wrapper of `import_from_github()` followed by `import_local_prefs()`
#'

#' @param clone_git boolean. Default is FALSE. Clone git for first time usage. A convenience function to avoid doing it manually, but it's essentially the same as doing `gert::git_clone("github_url")`. It will clone the repository inside your current working directory.
#' @param preference_path string. Input the file path where your preferences.json
#'   files are located.
#' @param pull_github boolean. Use TRUE to pull or clone from GitHub, otherwise FALSE
#'   to just import your local files.
#' @param git_url string. Allow to user the bypass the request of the git url to
#'   directly clone the desired git url repository
#'
#' @return Clone or pull from your github repository and import the RStudio preferences to the internal R Studio
#'   preference folder.
#' @export
#'
#' @examples
#' \dontrun{
#' start_import_prefs(pull_github = FALSE, preference_path = "R/rstudio_preferences/")
#' start_import_prefs(pull_github = TRUE)
#' start_import_prefs(clone_git = TRUE)
#' }
#'
start_import_prefs <-
  function(preference_path = "R/rstudio_preferences/",
           pull_github = TRUE,
           clone_git = FALSE,
           git_url = NULL) {
    if (pull_github == TRUE) {
      clone_path <- import_from_github(clone_git, git_url)
      if (clone_git) {
        preference_path <- paste0(get_latest_directory(clone_path), preference_path)
      }
    }
    import_local_prefs(preference_path)
  }


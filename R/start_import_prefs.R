#' Start the import process from local files or from GitHub
#'
#' Import preferences by cloning a link or pulling from your GitHub. The
#' function will start to pull from the currently active GitHub repository, then will import the local .json
#' preference files. The function will look for the specific .json files only, in the given file path.
#'
#' @seealso [import_from_github()] to just import, and [import_local_prefs()] to import locally
#' @details Function wrapper of `import_from_github()` followed by `import_local_prefs()`
#'
#' @param clone_git boolean: Default is FALSE. Clone git for first time usage. A convenience function to avoid doing it manually, but it's essentially the same as doing `git_clone("github_url")`. It will clone the repository inside your current working directory.
#' @param preference_path string: Input the file path where your preferences.json
#'   files are located.
#' @param github boolean: Use TRUE to pull or clone from GitHub, otherwise FALSE
#'   to just import your local files.
#'
#' @return Pull your github and import your preferences to the R Studio
#'   preference folder.
#' @export
#'
#' @examplesIf has_git_repository()
#' start_import_prefs(pull_github = FALSE, preference_path = "R/rstudio_preferences/")
#' start_import_prefs(pull_github = TRUE)
#'
start_import_prefs <- function(preference_path = "R/rstudio_preferences/", github = TRUE, clone_git = FALSE) {
  if (github == TRUE) {
    import_from_github(clone_git)
  }
  import_local_prefs(preference_path)
}

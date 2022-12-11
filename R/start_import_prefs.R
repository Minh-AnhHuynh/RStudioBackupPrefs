#' Start the import process from local files or from GitHub
#'
#' Import preferences by cloning a link or pulling from your GitHub. The
#' function will start to import from GitHub, then will import the local .json
#' preference files.
#'
#' @param pull_github boolean. Default is TRUE.
#' @param clone_git boolean: Default is FALSE. Clone git for first time usage.
#' @param preference_path Input file path where your preferences.json files are
#'   located.
#'
#' @return Pull your github and import your preferences to the R Studio
#'   preference folder.
#' @export
#'
#' @examplesIf has_git_repository()
#' start_import_prefs(pull_github = FALSE, preference_path = "R/rstudio_preferences/")
#' start_import_prefs(pull_github = TRUE)
#'
#'
start_import_prefs <- function(preference_path = ".", github = TRUE, clone_git = FALSE) {
  if (github == TRUE) {
    import_from_github(clone_git)
  }
  import_local_prefs(preference_path)
}

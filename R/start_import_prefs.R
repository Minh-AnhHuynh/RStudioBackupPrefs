#' Import preferences from GitHub
#'
#' Import preferences by cloning a link or pulling from your GitHub. The
#' function will start to import from GitHub, then will import local prefs
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
#' @examples
#' \dontrun{
#' start_import_prefs(pull_github = FALSE, preference_path = "/rstudio_preferences")
#' start_import_prefs(pull_github = TRUE)
#' }
#'
start_import_prefs <- function(pull_github = TRUE, clone_git = FALSE, preference_path = "/rstudio_preferences") {
  if (pull_github == TRUE) {
    import_from_github(clone_git)
  }
  import_local_prefs(preference_path)
}

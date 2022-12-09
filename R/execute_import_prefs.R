
#' Start the backup process
#'
#' @param github_backup boolean: Upload file to github.
#'
#' @return Function will start backing up your files in their folder to .bak and
#'   ask you if you want to back them up to github
#' @export
#'
#' @examples start_backup_prefs(github_backup = FALSE)
#'
start_backup_prefs <- function(github_backup) {
  local_prefs <- glue::glue("{here()}/rstudio_preferences")
  backup_prefs()

  if (github_backup == TRUE) {
    copy_files_to_local()
    upload_prefs_to_github()
  }
}


#' Import preferences from GitHub
#' Import preferences by cloning a link or pulling from your GitHub
#'
#' @param pull_github boolean. Default is TRUE.
#' @param clone_git boolean: Default is FALSE. Clone git for first time usage.
#'
#' @return Pull your github and import your preferences to the R Studio preference folder.
#' @export
#'
#' @examples start_import_prefs()
#'
start_import_prefs <- function(pull_github = TRUE, clone_git = FALSE) {
  if (pull_github == TRUE) {
    import_from_github(clone_git)
  }
  import_local_prefs()
}

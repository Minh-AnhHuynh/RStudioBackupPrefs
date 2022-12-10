#' Start the backup process
#'
#' Function will start backing up your files in their folder to .bak and ask you
#' if you want to back them up to GitHub. Make sure to have a git initiated
#' repository.
#'
#' @details Function wrapper using `backup_prefs()`. if github_backup = TRUE,
#'   will then use those functions: `copy_files_to_local()` and
#'   `upload_prefs_to_github()`
#'
#' @param github_backup boolean: Upload file to github.
#' @param preference_path string: Path to local backup folder.
#'
#' @return Copy rstudio_bindings.json, addins.json rstudio-bindings.json and
#'   r.snippets to .bak files in their native config folder. Then copy files to
#'   working directory in path and executes git push if `github_backup = TRUE`
#' @export
#'
#' @examples \dontrun{
#' start_backup_prefs(github_backup = TRUE)
#' }
#'
start_backup_prefs <- function(github_backup = FALSE, preference_path = "rstudio_preferences") {
  local_prefs <- glue::glue("{here()}/rstudio_preferences")
  backup_prefs()

  if (github_backup == TRUE) {
    copy_files_to_local(preference_path = "rstudio_preferences")
    upload_prefs_to_github()
  }
}

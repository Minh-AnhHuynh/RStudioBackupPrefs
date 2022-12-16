#' Start the backup process
#'
#' Function will start backing up your files in their folder to .bak. Make sure to have a git initiated
#' repository if you wish to upload to your GitHub repository.
#'
#' @details Function wrapper using `backup_prefs()`. if github_backup = TRUE,
#'   will then use those functions: `copy_files_to_local()` and
#'   `upload_prefs_to_github()`
#'
#' @param github_backup boolean: Upload file to github.
#' @param preference_path string: Path to local backup folder
#' @param git_message string: Your git commit message. Default is Backup of R Studio preferences on `Sys.Date()`."
#' @param repository string. Defaults to the current git repository.
#' @param copy_to_local boolean: Copy your .json files to local if TRUE.
#' @param open_backup_path boolean: Open the default backup folder for convenience if TRUE.
#'
#' @return Copy rstudio_bindings.json, addins.json rstudio-bindings.json and
#'   r.snippets to .bak files in their native config folder. Then copy files to
#'   working directory in path and executes git push if `github_backup = TRUE`
#' @export
#'
#' @examplesIf has_git_repository()
#' # Leave defaults to simply backup.
#' start_backup_prefs()
#'
#' # Customize preferences and git_message
#' start_backup_prefs(
#'   github_backup = TRUE,
#'   preference_path = "R/rstudio_preferences/",
#'   git_message = "Backup preferences"
#' )
#'
start_backup_prefs <-
  function(github_backup = FALSE,
           copy_to_local = FALSE,
           open_backup_path = FALSE,
           preference_path = "R/rstudio_preferences/",
           git_message = "Backup of R Studio preferences on {Sys.Date()}",
           repository = ".") {
    backup_prefs(open_backup_path)
    if (copy_to_local == TRUE | github_backup == TRUE) {
      copy_files_to_local(preference_path)
    }
    if (github_backup == TRUE) {
      upload_prefs_to_github(preference_path, git_message, repository)
    }
  }

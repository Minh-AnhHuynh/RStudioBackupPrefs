#' Start the backup process from local to github
#'
#' Function will start backing up your files in their folder to .bak. Make sure
#' to have a git initiated repository if you wish to upload to your GitHub
#' repository.
#'
#' @details Function wrapper using `backup_prefs()`. if github_backup = TRUE,
#'   will then use those functions: `copy_files_to_local()` and
#'   `upload_prefs_to_github()`
#'
#' @param github_backup logical. Upload file to github.
#' @param preference_path string. Path to local backup folder
#' @param git_message string. Your git commit message. Default is "Backup of R
#'   Studio preferences on `Sys.Date()`."
#' @param repository string. Defaults to the current git repository. If you want
#'   to upload to another repository, specify the path.
#' @param copy_to_local logical. Copy your .json files to local if TRUE. It will
#'   copy the files to the repository folder if specified.
#' @param open_backup_path logical. Open the default backup folder for
#'   convenience if TRUE.
#'
#' @return Backup rstudio_bindings.json, addins.json rstudio-bindings.json and
#'   r.snippets to .bak files in their native rstudioconfig folder. Then copy
#'   files to working directory in chosen file path and executes git push if
#'   `github_backup = TRUE`
#' @export
#'
#' @examples
#' # Copy files to the selected directory
#' temp_dir <- tempdir()
#' start_backup_prefs(copy_to_local = TRUE, preference_path = temp_dir)
#' unlink(temp_dir)
#'
#' \dontrun{
#' # Backup prefs to the current git initiated repository
#' start_backup_prefs(github_backup = TRUE)
#'
#' # Backup prefs to another local git repository that is not the current one,
#' # matching one in the cloud
#' start_backup_prefs(github_backup = TRUE, repository = "../MyRStudioPrefs")
#' }
#'
start_backup_prefs <-
  function(preference_path = "R/rstudio_preferences",
           github_backup = FALSE,
           copy_to_local = FALSE,
           open_backup_path = FALSE,
           git_message = "Backup of R Studio preferences on {Sys.Date()}",
           repository = ".") {
    backup_prefs(open_backup_path)
    # You can't add files directly from the rstudio paths, you HAVE to copy to
    # local because the git repo has to be the current one initiated. Delete
    # afterwards if you want
    oldwd <- getwd()
    if (!repository == ".") {
      # Check if there is a local repository of the correct name
      if (!fs::dir_exists(repository)) {
        stop("You can't upload preferences without a git repository.")
      }
    }
    setwd(repository)
    if (copy_to_local == TRUE || github_backup == TRUE) {
      copy_files_to_local(preference_path)
    }

    if (github_backup == TRUE) {
      upload_prefs_to_github(preference_path, git_message, repository)
    }

    setwd(oldwd)
  }


#' Upload preferences to GitHub
#'
#' Add, commit and push your .json files automatically with a folder name.
#'
#' @param git_message string. Enter a git commit message.
#' @param preference_path string. Relative file path name.
#'
#' @return Upload your .json files to currently active git repository.
#' @export
#' @examples \dontrun{
#' upload_prefs_to_github("/rstudio_preferences")
#' upload_prefs_to_github("/rstudio_preferences", git_message = "Backup preferences")
#' }
#'
upload_prefs_to_github <- function(preference_path = "/rstudio_preferences",
                                   git_message = "Backup of R Studio preferences on {Sys.Date()}.") {
  local_prefs <- glue::glue("{here::here()}{preference_path}")
  prefs_files <- list.files(local_prefs)

  # Add files, commit and push
  git_add(glue::glue("{preference_path}/{prefs_files}")) # Relative path names

  git_commit(message = glue::glue(git_message))
  git_push()
}

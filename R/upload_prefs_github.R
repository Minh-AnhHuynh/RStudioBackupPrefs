
#' Upload preferences to GitHub
#'
#' Add, commit and push your .json files automatically.
#'
#' @param preference_path_name string. Relative file path name
#'
#' @return Will upload your .json files to your initiated git repository.
#' @export
#'
#' @examples upload_prefs_to_github()
upload_prefs_to_github <- function(preference_path_name = "rstudio_preferences") {
  local_prefs <- glue::glue("{here::here()}/{preference_path_name}")
  prefs_files <- list.files(local_prefs)

  # Add files, commit and push
  git_add(glue::glue("{preference_path_name}/{prefs_files}")) # Relative path names

  git_commit(message = glue::glue("Backup of R Studio preference files on {Sys.Date()}."))
  git_push()
}

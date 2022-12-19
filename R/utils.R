
#' Check existence of the RStudio preference files in the given file path.
#'
#' Will also return the file names for convenience.
#'
#' @param preference_path Default to working directory
#'
#' @noRd
check_json_existence <- function(preference_path = ".") {
  prefs_files <-
    c(
      "rstudio-prefs.json",
      "rstudio_bindings.json",
      "addins.json",
      "r.snippets"
    )
  local_files <-
    fs::file_exists(glue("{preference_path}/{prefs_files}"))
  if (all(assertive::is_false(local_files))) {
    stop("No .json preference files are found. Please check the file path.")
  }
  local_files <-
    names(local_files[which(local_files)]) # Get file names
  return(local_files)
}

#' Does it have a valid git repository?
#'
#' Simply check for git status and assert that it is error free. Internal usage.
#' @export
has_git_repository <- function() {
  assertive::is_error_free(git_status())
}

#' Return rstudio_config_path
#'
#' Imported from `usethis:::rstudio_config_path()`
#'
#' @noRd
#'
rstudio_config_path <- function(...) {
  if (assertive::is_windows()) {
    base <- rappdirs::user_config_dir("RStudio", appauthor = NULL)
  } else {
    base <- rappdirs::user_config_dir("rstudio", os = "unix")
  }
  fs::path(base, ...)
}

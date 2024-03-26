#' Start the import process from Github by default or your local json preference files
#'
#' @description Import preferences by cloning a link or pulling from your GitHub. The
#' function will start to pull from the currently active GitHub repository, then
#' will import the local .json preference files. The function will look for the
#' specific .json files only, in the given file path. If cloning is chosen, the
#' folder will be inside the working directory.
#'
#' @details Function wrapper of `import_from_github()` followed by `import_local_prefs()`
#'

#' @param clone_git boolean. Default is FALSE. Clone git for first time usage. A convenience function to avoid doing it manually, but it's essentially the same as doing `gert::git_clone("github_url")`. It will clone the repository inside your current working directory.
#' @param preference_path string. Input the file path where your preferences.json
#'   files are located.
#' @param pull_github boolean. Use TRUE to pull or clone from GitHub, otherwise FALSE
#'   to just import your local files.
#' @param git_url string. Allows to user the bypass the request of the git url to
#'   directly clone the desired git url repository to the working directory.
#'
#' @returns Clone repository or preference files copied to RStudio's preference folder
#' @export
#'
#' @examples
#' # To import your preferences from locally stored preferences files:
#'
#' # Dummy preference files
#' temp_dir <- tempdir()
#' fs::file_create(file.path(temp_dir, "addins.json"))
#' fs::file_create(file.path(temp_dir, "rstudio_bindings.json"))
#' fs::file_create(file.path(temp_dir, "r.snippets"))
#' fs::file_create(file.path(temp_dir, "rstudio-prefs.json"))
#' start_import_prefs(pull_github = FALSE, preference_path = temp_dir)
#' \dontrun{
#' # To import your preferences from Github:
#' start_import_prefs()
#' }
start_import_prefs <-
  function(preference_path = "R/rstudio_preferences/",
           pull_github = TRUE,
           clone_git = FALSE,
           git_url = NULL) {
    if (pull_github == TRUE) {
      # Even if preference path is not in the root of a git folder, git pull
      # will still work
      clone_path <- import_from_github(clone_git, git_url, preference_path)
      if (clone_git == TRUE) {
        preference_path <- paste0(get_latest_directory(clone_path), preference_path)
      }
    }
    import_local_prefs(preference_path)
  }

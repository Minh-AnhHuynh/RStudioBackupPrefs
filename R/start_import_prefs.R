#' Start the import process from GitHub by default or your local json preference files
#'
#' @description Import preferences by cloning a link or pulling from your GitHub. The
#' function will start to pull from the currently active GitHub repository, then
#' will import the local .json preference files. The function will look for the
#' specific .json files only, in the given file path. If cloning is chosen, the
#' folder will be inside the working directory.
#'
#' @details Function wrapper of `import_from_github()` followed by `import_local_prefs()`
#'

#' @param clone_git logical. Default is FALSE. Clone git for first time usage. A convenience function to avoid doing it manually, but it's essentially the same as doing `gert::git_clone("github_url")`. It will clone the repository inside your current working directory.
#' @param preference_path string. Input the file path where your preferences json
#'   files are located.
#' @param pull_github logical. Use TRUE to pull or clone from GitHub, otherwise FALSE
#'   to just import your local files.
#' @param git_url string. Allows to user the bypass the request of the git url to
#'   directly clone the desired git url repository to the working directory.
#'
#' @returns Cloned repository and/or preference files copied to RStudio's preference folder
#'
#' @seealso Use [list_github_repositories()] to list the current Git user's repositories.
#'
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
#'
#' # Import from local files
#' start_import_prefs(pull_github = FALSE, preference_path = temp_dir)
#'
#' \dontrun{
#' # Pull from GitHub from your current Git initiated repository
#' start_import_prefs(preference_path = temp_dir)
#'
#' # First time usage, clone the repository, the function will ask for the git
#' url and clone it to the working directory
#' start_import_prefs(preference_path = temp_dir, clone_git = TRUE)
#'
#' # Clone a specific repository in a specific folder
#' start_import_prefs(preference_path = temp_dir, git_url = "https://github.com/cran/dummies/tree/master", git_path = "../MyRStudioPrefs")
#' }
#'
start_import_prefs <-
  function(preference_path = "R/rstudio_preferences/",
           pull_github = TRUE,
           clone_git = FALSE,
           git_url = NULL,
           git_path = ".") {
    if (pull_github == TRUE) {
      # Even if preference path is not in the root of a git folder, git pull
      # will still work

      # Assume the user wants to clone if entering a git url
      if (!is.null(git_url)) {
        clone_git <- TRUE
      }
      clone_path <-
        import_from_github(clone_git, git_url, git_path = git_path)
      preference_path <- paste0(clone_path, preference_path)
      # if (clone_git == TRUE) {
      #   preference_path <-
      #     paste0(get_latest_directory(clone_path), preference_path)
      # }
    }
    import_local_prefs(preference_path)
  }

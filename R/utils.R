
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
      "keybindings/rstudio_bindings.json",
      "keybindings/addins.json",
      "keybindings/r.snippets",
      "keybindings/editor_bindings.json"
    )
  local_files <-
    fs::file_exists(glue("{preference_path}/{prefs_files}"))
  if (!any(local_files)) {
    stop("No .json preference files are found. Please check the file path.")
  }
  local_files <-
    names(local_files[which(local_files)]) # Get file names
  return(local_files)
}



#' Simple function to verify if there is an error (TRUE) or not (FALSE)
#'
#' @noRd
#' @examples verify_is_error(git_info())
verify_is_error <- function(expr) {
  tryCatch({
    expr
  }, error = function(e) {
    return(TRUE)
  })
  return(FALSE)
}


#' Does it have a valid git repository?
#'
#' Simply check for git status and assert that it is error free. Internal usage.
#' @export
has_git_repository <- function() {
  !verify_is_error(git_info())
}


#' Is it a windows machine?
#'
#' @noRd
#'
is_windows <- function() {
  # Get information about the current operating system
  sys_info <- Sys.info()

  # Check if the operating system is Windows
  return(tolower(sys_info['sysname']) == "windows")
}


#' Return rstudio_config_path
#'
#' Imported from `usethis:::rstudio_config_path()`
#'
#' @noRd
#'
rstudio_config_path <- function(...) {
  if (is_windows()) {
    base <- rappdirs::user_config_dir("RStudio", appauthor = NULL)
  } else {
    base <- rappdirs::user_config_dir("rstudio", os = "unix")
  }
  fs::path(base, ...)
}


#' List the online git repositories of the current user
#'
#' @param username
#'
#' @return A list of the current public repositories for the current git user
#' @noRd
#' @examples
#' list_github_repositories(get_current_git_username())
#'
list_github_repositories <- function(username) {
  # Set up the API endpoint
  url <- paste0("https://api.github.com/users/", username, "/repos")
  # Make the HTTP request
  response <- httr::GET(url)

  # Check if the request was successful
  if (httr::http_type(response) == "application/json") {
    # Extract repository names
    repos <- httr::content(response)
    repo_names <- sapply(repos, function(repo) repo$svn_url)

    # Print the list of repositories
    cat("GitHub repositories for user", username, ":\n")
    for (repo in repo_names) {
      cat("- ", repo, "\n")
    }
  } else {
    cat("Failed to retrieve repository information.\n")
    cat("Response status:", httr::status_code(response), "\n")
    cat("Response content:", httr::content(response, as = "text"), "\n")
  }
}



#' Call the function to get the current Git username
#'
#' @return string: Current git username.
#' @noRd
#'
#' @examples
#' Call the function to get the current Git username
#' current_username <- get_current_git_username()
#'
get_current_git_username <- function() {
  # Run git config command to get the current user.name
  config <- gert::git_config()
  current_username <- config[config$name == "user.name",]$value
  # Print the current username
  cat("Current Git username:", current_username, "\n")
  return(current_username)
}

#' Get latest directory for import_from_github path
#'
#' @param parent_path
#'
#' @return string: Directory path of the cloned git_url
#' @noRd
#'
get_latest_directory <- function(parent_path) {
  # List directories in the parent_path
  directories <- list.dirs(parent_path, full.names = TRUE)

  # Extract only directories (excluding files)
  directories <- directories[file.info(directories)$isdir]

  # Sort directories by modification time (latest first)
  directories <- directories[order(file.info(directories)$mtime, decreasing = TRUE)]

  # Select the first directory (latest one)
  latest_directory <- directories[1]

  return(latest_directory)
}


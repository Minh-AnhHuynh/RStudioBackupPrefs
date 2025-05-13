#' Internal function usage to get the vector of json files to copy. Useful when
#' there is a file missing such as r.snippets
#' @noRd
files_to_copy <- function(rstudio_pref_path = rstudio_config_path()) {
  pref_path <- glue::glue("{rstudio_pref_path}")
  prefs <- glue::glue("{pref_path}/rstudio-prefs.json.bak")
  bindings <-
    glue::glue("{pref_path}/keybindings/rstudio_bindings.json.bak")
  addins <- glue::glue("{pref_path}/keybindings/addins.json.bak")
  snippets <- glue::glue("{pref_path}/snippets/r.snippets.bak")


  # Make a vector of files to copy that exists
  files_to_copy_name <- c(prefs, bindings, addins, snippets)
  files_to_copy <- fs::file_exists(files_to_copy_name)
  files_to_copy_name <-
    files_to_copy_name[files_to_copy] # Keep TRUE value
  return(files_to_copy_name)
}


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
    fs::file_exists(glue::glue("{preference_path}/{prefs_files}"))
  if (!any(local_files)) {
    stop("No .json preference files are found. Please check the file path.")
  }
  local_files <-
    names(local_files[which(local_files)]) # Get file names
  return(local_files)
}

#' Internal function to copy user dictionary to the local folder
#'
#' @noRd
#' @examples get_user_dictionary_file()
get_user_dictionary_file <- function() {
  # Get the user dictionary path
  user_dic_path <- rappdirs::user_data_dir("RStudio/monitored/lists", appauthor = NULL)
  user_dictionary <- file.path(user_dic_path, "user_dictionary")
  return(user_dictionary)
}



#' Simple function to verify if there is an error (TRUE) or not (FALSE)
#'
#' @noRd
#' @examples verify_is_error(git_info())
verify_is_error <- function(expr) {
  tryCatch(
    {
      expr
    },
    error = function(e) {
      return(TRUE)
    }
  )
  return(FALSE)
}


#' Does it have a valid git repository?
#'
#' Simply check for git status and assert that it is error free.
#' @noRd
has_git_repository <- function() {
  !verify_is_error(gert::git_find())
}


#' Is it a windows machine?
#'
#' @noRd
#'
is_windows <- function() {
  # Get information about the current operating system
  sys_info <- Sys.info()

  # Check if the operating system is Windows
  return(tolower(sys_info["sysname"]) == "windows")
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

#' Upload preferences to GitHub
#'
#' Add, commit and push your .json files automatically with the name
#'
#' @param git_message string. Enter a git commit message.
#' @param preference_path string. Relative file path name
#' @param repository string. Defaults to the current git repository.
#'
#' @return Upload your .json files to currently active git repository.
#' @export
#' @examplesIf has_git_repository()
#' # Upload preferences to currently active git repository
#' upload_prefs_to_github("R/rstudio_preferences/")
#'
#' # Upload preferences to currently active git repository with a custom git commit message
#' upload_prefs_to_github("R/rstudio_preferences/", git_message = "Backup preferences")
#' #'
upload_prefs_to_github <-
  function(preference_path = "R/rstudio_preferences/",
           git_message = "Backup of R Studio preferences on {Sys.Date()}.",
           repository = ".") {
    # Check if the preference path exists
    if (!file.exists(preference_path)) {
      stop("Error: the preference path does not exist.")
    }
    check_json_existence(preference_path)

    # Initiate a repository and create a GitHub repository if no initiated repository
    if (has_git_repository() == FALSE) {
      if (yesno::yesno("There is no initiated git repository. Do you want to initiate one and create a new repository?") == TRUE) {
        usethis::use_git()
        usethis::use_github()
      }
    }

    if (any(assertive::is_true(git_status()$staged))) {
      # Prompt user to confirm whether to unstage files
      yes_unstage <-
        yesno::yesno("There are staged files, do you want to unstage?")
      if (yes_unstage == TRUE) {
        # Attempt to unstage files
        tryCatch(
          {
            shell("git reset")
          },
          error = function(e) {
            stop("Error: failed to unstage files.")
          }
        )
      }
    }
    # Add files to Git repository
    tryCatch(
      {
        git_add(glue::glue("{preference_path}/{prefs_files}")) # Relative path names
      },
      error = function(e) {
        stop("Error: failed to add files to Git repository.")
      }
    )
    # Commit changes
    tryCatch(
      {
        git_commit(message = glue::glue(git_message))
      },
      error = function(e) {
        stop("Error: failed to commit changes.")
      }
    )
    # Push changes to GitHub
    tryCatch(
      {
        git_push()
      },
      error = function(e) {
        stop("Error: failed to push changes to GitHub.")
      }
    )
  }

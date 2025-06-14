#' Upload preferences to GitHub
#'
#' Add, commit and push your .json files automatically with the name
#'
#' @param git_message string. Enter a git commit message.
#' @param preference_path string. Relative file path name
#' @param repository string. Defaults to the current git repository.
#'
#' @return Upload your prefs files to currently active git repository.
#' @noRd
#' @examples
#'
#' # Setup
#' oldwd <- getwd()
#' repo <- file.path(tempdir(), "myrepo")
#' gert::git_init(repo)
#' setwd(repo)
#'
#' # Upload preferences to currently active git repository
#' upload_prefs_to_github("R/rstudio_preferences/")
#'
#' # Upload preferences to currently active git repository with a custom git commit message
#' upload_prefs_to_github("R/rstudio_preferences/", git_message = "Backup preferences")
#'
#' # Cleanup
#' setwd(oldwd)
#' unlink(repo, recursive = TRUE)
#'
upload_prefs_to_github <-
  function(preference_path = "R/rstudio_preferences/",
           git_message = "Backup of R Studio preferences on {Sys.Date()}.",
           repository = ".") {
    # Check if the preference path exists
    if (!file.exists(preference_path)) {
      stop("Error: the preference path does not exist.")
    }
    check_json_existence(preference_path)

    # Change repository if different
    oldwd <- getwd()
    if (interactive() == TRUE) {
      session_is_interactive <- TRUE
    } else {
      session_is_interactive <- FALSE
    }
    if (!repository == ".") setwd(repository)


    # Initiate a repository and create a GitHub repository if no initiated repository
    if (has_git_repository() == FALSE && session_is_interactive == TRUE) {
      if (yesno::yesno("There is no initiated git repository.
                       Do you want to initiate one and create a new repository on Github?") == TRUE) {
        usethis::use_git()
        usethis::use_github()
      } else {
        stop("You can't upload preferences without a git repository.")
      }
    }
    if (any(gert::git_status()$staged) == TRUE && session_is_interactive == TRUE) {
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
    prefs_files <-
      c(
        "rstudio-prefs.json",
        "rstudio_bindings.json",
        "addins.json",
        "r.snippets",
        "editor_bindings.json",
        "user_dictionary"
      )
    list_prefs <- list.files(preference_path)
    filtered_files <- list_prefs[list_prefs %in% prefs_files]
    filtered_files <- fs::path(preference_path, filtered_files)
    # fs::path prevents double slashes "//" in the path which bugs out
    # gert::git_add afterwards
    gert::git_add(filtered_files)

    # Commit changes
    gert::git_status()
    gert::git_commit(message = glue::glue(git_message))

    # Push changes to GitHub
    tryCatch(
      {
        gert::git_push()
      },
      error = function(e) {
        stop("Error: failed to push changes to GitHub.")
      }
    )

    # Go back to previous working directory if repository was changed
    on.exit(setwd(oldwd))
  }

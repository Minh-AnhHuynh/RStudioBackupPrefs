#' Import preferences from a GitHub url
#'
#' Pull (or clone) from your own git repository which
#' should contain your backup preference files. The function will attempt to pull your current git repository by default.
#'
#' @param clone_git boolean. Use this option if you haven't initiated a repository.
#'
#' @return Clone or pull from a GitHub link from a user prompt.
#' @export
#'
#' @examplesIf has_git_repository()
#' import_from_github()
#' import_from_github(clone_git = TRUE)
import_from_github <-
  function(clone_git = FALSE,
           target_dir = NULL) {
    if (clone_git || !has_git_repository()) {
      if (!is.null(target_dir)) {
        withr::with_dir(target_dir, {
          repo <- readline("Enter the URL of your repository: ")
          gert::git_clone(repo)
        })
      } else {
        repo <- readline("Enter the URL of your repository: ")
        gert::git_clone(repo)
      }
    } else {
      message("Pull git repository.")
      gert::git_pull()
    }
  }


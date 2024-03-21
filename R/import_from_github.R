#' Import preferences from a GitHub url
#'
#' Pull (or clone) from your own git repository which
#' should contain your backup preference files. The function will attempt to pull your current git repository by default.
#'
#' @param clone_git boolean. Use this option if you haven't initiated a repository.
#' @param git_url string. Allow to user the bypass the request of the git url to
#'   directly clone the desired git url repository
#'
#' @return Clone or pull from a GitHub link from a user prompt.
#' @export
#'
#' @examples
#' \dontrun{
#' # Setup
#' oldwd <- getwd()
#' repo <- file.path(tempdir(), "myrepo")
#' gert::git_init(repo)
#' setwd(repo)
#'
#' # Use import_from_github
#' import_from_github()
#' import_from_github(clone_git = TRUE)
#' import_from_github(git_url = https://git_url.com)
#' }
#'
import_from_github <- function(clone_git = FALSE,
                               git_url = NULL) {
  if (clone_git == TRUE || has_git_repository() == FALSE) {
    if (!is.null(git_url)) {
      repo <- git_url
    } else {
      list_github_repositories(get_current_git_username())
      repo <- readline("Enter url of your git repository: ")
    }
    tryCatch(
      {
        clone_path <- gert::git_clone(repo)
        return(clone_path)
      },
      error = function(e) {
        message("Error occurred while cloning the repository:", e$message)
        return(NULL)
      }
    )
  } else {
    message("Pull git repository.")
    gert::git_pull()
  }
}

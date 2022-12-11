
#' Import preferences from a GitHub url
#'
#' Clone or pull from your own git repository which
#' should contain your backup preference files.
#'
#' @param clone_git boolean. Use this option if your folder doesn't have an initiated repository.
#'
#' @return Clone or pull from GitHub link.
#' @export
#'
#' @examples \dontrun{
#' import_from_github()
#' import_from_github(clone_git = TRUE)
#' }
import_from_github <- function(clone_git = FALSE) {
  if (clone_git == TRUE | has_git_repository() != TRUE) {
    repo <- readline("Enter url of your repository: ")
    gert::git_clone(repo)
  } else {
    message("Pull git repository.")
    gert::git_pull()
  }
}

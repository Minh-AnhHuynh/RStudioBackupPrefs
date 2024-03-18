
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
#' @examples
#' \dontrun{
#' # Setup (inspired from gert)
#' oldwd <- getwd()
#' repo <- file.path(tempdir(), "myrepo")
#' gert::git_init(repo)
#' setwd(repo)
#'
#' # Use import_from_github
#' import_from_github()
#' import_from_github(clone_git = TRUE)
#' }
#'
import_from_github <- function(clone_git = FALSE) {
  if (clone_git == TRUE || has_git_repository() != TRUE) {
    repo <- readline("Enter url of your repository: ")
    gert::git_clone(repo)
  } else {
    message("Pull git repository.")
    gert::git_pull()
  }
}

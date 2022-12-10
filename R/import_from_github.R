
#' Import preferences from a GitHub url
#'
#' Clone a git repository from url or pull from your own git repository which
#' should ideally contain your backup preference files.
#'
#' @param clone_git boolean. TRUE or FALSE.
#'
#' @return Clone or pull from GitHub link.
#' @export
#'
#' @examples \dontrun{
#' import_from_github()
#' import_from_github(clone_git = TRUE)
#' }
import_from_github <- function(clone_git = FALSE) {
  if (clone_git == TRUE) {
    repo <- readline(prompt = "Enter url of your repository : ")
    gert::git_clone(repo)
  } else {
    message("Pull git repository.")
    gert::git_pull()
  }
}

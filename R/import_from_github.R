
#' Import preferences from a github url
#'
#' @return Clone a git repository from url or pull from your own git repository.
#' @export
#' @usage NULL
import_from_github <- function(clone_git = FALSE) {
  if (clone_git == TRUE) {
    repo <- readline(prompt = "Enter url of your repository : ")
    gert::git_clone(repo)
  } else {
    message("Pull git repository.")
    gert::git_pull()
  }
}

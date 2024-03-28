#' Import preferences from a GitHub url
#'
#' Pull (or clone) from your own git repository which
#' should contain your backup preference files. The function will attempt to pull your current git repository by default.
#'
#' @param clone_git logical. Use this option if you haven't initiated a repository.
#' @param git_url string. Allow to user the bypass the request of the git url to
#'   directly clone the desired git url repository
#' @param git_path string. Git path to the repository to pull from.
#'
#' @return Clone or pull from a GitHub link from a user prompt.
#' @noRd
#' @examples
#' \dontrun{
#' # Pull changes from a GitHub repository
#' import_from_github()
#'
#' # Clone a repository from GitHub, function will ask for the git url
#' import_from_github(clone_git = TRUE)
#' # Clone a repository from GitHub, bypass the request for the git url
#' # The function will assume clone_git = TRUE
#' import_from_github(git_url = "https://github.com/cran/dummies")
#' }
import_from_github <- function(clone_git = FALSE, git_url = NULL, git_path = ".") {
  if (clone_git == TRUE || has_git_repository() == FALSE || !is.null(git_url)) {
    if (!is.null(git_url)) {
      repo <- git_url
    } else {
      list_github_repositories()
      repo <- readline("Enter url of your git repository: ")
    }
    full_path <- file.path(git_path)
    tryCatch(
      {
        clone_path <- gert::git_clone(repo, path = full_path)
        return(clone_path)
      },
      error = function(e) {
        message("Error occurred while cloning the repository:", e$message)
        return(NULL)
      }
    )
  } else {
    message(glue::glue("Pull {gert::git_find(git_path)} git repository"))
    gert::git_pull(repo = git_path)
  }
}

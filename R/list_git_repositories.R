#' List the online git repositories of the current user
#'
#' @param username string. The git username to list the repositories. Default is
#'   the current git username.
#'
#' @return A list of the current public repositories for the current git user
#' @export
#' @examples
#' list_github_repositories("cran")
#' \dontrun{
#' list_github_repositories()
#' }
#'
list_github_repositories <- function(username = get_current_git_username) {
  if (is.function(username)) {
    username <- username()
  }
  # Set up the API endpoint0
  url <- paste0("https://api.github.com/users/", username, "/repos")
  # Make the HTTP request
  response <- tryCatch(httr::GET(url),
                       error = function(e) {
                         return("Error in retrieving repository, is your git user.name valid?")
                       })

  # Check if the request was successful
  if (httr::http_type(response) == "application/json") {
    # Extract repository names
    repos <- httr::content(response)
    repo_names <- sapply(repos, function(repo) repo$svn_url)

    # Print the list of repositories
    cat("GitHub repositories for user", username, ":\n")
    for (repo in repo_names) {
      cat("- ", repo, "\n")
    }
  } else {
    cat("Failed to retrieve repository information.\n")
    cat("Response status:", httr::status_code(response), "\n")
    cat("Response content:", httr::content(response, as = "text"), "\n")
  }
}



#' Call the function to get the current Git username
#'
#' @return string: Current git username.
#' @noRd
#'
#' @examples get_current_git_username()
#'
get_current_git_username <- function() {
  # Run git config command to get the current user.name
  config <- gert::git_config()
  # Select the current local user.name first, and if not local select the global one
  current_username <- subset(config, name == "user.name" & level == "local")$value
  if (is.na(current_username)) {
    current_username <- subset(config, name == "user.name" & level == "global")$value
  }
  # Print the current username
  cat("Current Git username:", current_username, "\n")
  return(current_username)
}

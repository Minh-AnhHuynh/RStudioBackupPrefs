librarian::shelf(glue, gert)

import_from_github <- function() {
  clone_yes <- yesno2("Do you want to clone your git ?")
  if (clone_yes == TRUE) {
    repo <- readline(prompt = "Enter url of your repository : ")
    gert::git_clone(repo)
  } else {
    message("Pull git repository.")
    gert::git_pull()
  }
}

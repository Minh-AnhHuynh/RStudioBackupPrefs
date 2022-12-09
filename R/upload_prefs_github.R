librarian::shelf(gert, glue, here)

upload_prefs_to_github <- function(preference_path_name = "rstudio-preferences") {
  local_prefs <- glue("{here()}/{preference_path_name}")
  prefs_files <- list.files(local_prefs)

  # Add files, commit and push
  git_add(glue("{preference_path_name}/{prefs_files}")) # Relative path names

  git_commit(message = glue("Backup of R Studio preference files on {Sys.Date()}."))
  git_push()
}

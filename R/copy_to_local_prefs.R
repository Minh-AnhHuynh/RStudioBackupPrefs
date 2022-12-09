librarian::shelf(usethis, glue, here)

files_to_copy <- function() {
  pref_path <- glue("{usethis:::rstudio_config_path()}")
  prefs <- glue("{pref_path}/rstudio-prefs.json.bak")
  bindings <- glue("{pref_path}/keybindings/rstudio_bindings.json.bak")
  addins <- glue("{pref_path}/keybindings/addins.json.bak")
  snippets <- glue("{pref_path}/r.snippets.bak")
  local_prefs <- glue("{here()}/rstudio-preferences")


  # Make a vector of files to copy that exists
  files_to_copy_name <- c(prefs, bindings, addins, snippets)
  files_to_copy <- file_exists(files_to_copy_name)
  files_to_copy_name <- files_to_copy_name[files_to_copy] # Keep TRUE value
  return(files_to_copy_name)
}


copy_files_to_local <- function() {
  files_to_copy_name <- files_to_copy()
  local_prefs <- glue("{here()}/rstudio-preferences")
  # Copy files and remove .bak
  file_copy(files_to_copy_name, local_prefs, overwrite = TRUE)
  prefs_name <- list.files(local_prefs, full.names = TRUE)
  remove_bak <- stringr::str_remove_all(prefs_name, ".bak")
  file.rename(prefs_name, remove_bak)
  cli <-
    cli_alert_success("Preferences files copied to {list.files(local_prefs, full.names = TRUE)}",
                      wrap = TRUE)
}

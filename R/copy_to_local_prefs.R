
#' Copy backup files to a chosen local folder
#'
#' @param preference_path string: Use a relative file path, don't add a "/" at
#'   the end
#'
#' @return Copy addins.json, r.snippets, rstudio_bindings.json, prefs.json to
#'   folder in your working directory
#' @export
#'
#' @examples copy_files_to_local()
#'
copy_files_to_local <- function(preference_path = "rstudio_preferences") {
  files_to_copy_name <- files_to_copy()
  local_prefs <- glue::glue("{here::here()}/{preference_path}/")

  # Copy files and remove .bak
  fs::dir_create(local_prefs)
  fs::file_copy(files_to_copy_name, local_prefs, overwrite = TRUE)
  prefs_name <- list.files(local_prefs, full.names = TRUE)
  remove_bak <- stringr::str_remove_all(prefs_name, ".bak")
  file.rename(prefs_name, remove_bak)
  cli <-
    cli::cli_alert_success("Preferences files copied to {list.files(local_prefs, full.names = TRUE)}",
      wrap = TRUE
    )
}


#' Internal function usage to get the vector of json files to copy. Useful when
#' there is a file missing such as r.snippets
#' @usage NULL
#' @noRd
files_to_copy <- function() {
  pref_path <- glue::glue("{usethis:::rstudio_config_path()}")
  prefs <- glue::glue("{pref_path}/rstudio-prefs.json.bak")
  bindings <- glue::glue("{pref_path}/keybindings/rstudio_bindings.json.bak")
  addins <- glue::glue("{pref_path}/keybindings/addins.json.bak")
  snippets <- glue::glue("{pref_path}/r.snippets.bak")
  local_prefs <- glue::glue("{here::here()}/rstudio-preferences")


  # Make a vector of files to copy that exists
  files_to_copy_name <- c(prefs, bindings, addins, snippets)
  files_to_copy <- fs::file_exists(files_to_copy_name)
  files_to_copy_name <- files_to_copy_name[files_to_copy] # Keep TRUE value
  return(files_to_copy_name)
}

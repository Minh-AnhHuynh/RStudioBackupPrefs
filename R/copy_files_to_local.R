#' Copy backup files to a chosen local folder
#'
#' @param preference_path string: Use a relative file path, don't add a "/" at
#'   the end.
#' @param rstudio_pref_path string: Default RStudio preference path.
#'
#' @return Copy addins.json, r.snippets, rstudio_bindings.json, prefs.json to
#'   folder in your working directory
#' @noRd
#' @examples
#' temp_dir <- tempdir()
#' copy_files_to_local(temp_dir)
#' unlink(temp_dir)
#'
copy_files_to_local <-
  function(preference_path = "R/rstudio_preferences/",
           rstudio_pref_path = rstudio_config_path()) {
    files_to_copy_name <- files_to_copy(rstudio_pref_path)
    local_prefs <- glue::glue("{preference_path}")

    # Copy files and remove .bak
    fs::dir_create(local_prefs)
    fs::file_copy(files_to_copy_name, local_prefs, overwrite = TRUE)
    prefs_name <- list.files(local_prefs, full.names = TRUE)
    remove_bak <- stringr::str_remove_all(prefs_name, ".bak")
    file.rename(prefs_name, remove_bak)
    cli::cli_alert_success("Preferences files copied to
                           {.path {local_prefs}}",
      wrap = TRUE
    )
  }

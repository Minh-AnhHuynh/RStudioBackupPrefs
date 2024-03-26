#' Import local preferences files to R Studio
#'
#' @param preference_path string: Relative folder_path where .json files are
#'   contained.
#' @param rstudio_pref_path string: Default rstudio_config_path.
#'
#' @return Import addins.json, rstudio_bindings.json, r.snippets to the
#'   keybindings folder and rstudio-prefs.json to the RStudio folder
#' @noRd
#' @examples
#' \dontrun{
#' import_local_prefs("R/rstudio_preferences/")
#' }
import_local_prefs <-
  function(preference_path = "R/rstudio_preferences/",
           rstudio_pref_path = rstudio_config_path()) {
    check_json_existence(preference_path)


    # List the file names and only add existing files
    # For example, r.snippets might not exist
    # use vector1[vector2] to only retain TRUE value.
    list <- list.files(glue::glue("{preference_path}"))
    keybinding_files <-
      list[list %in% c("addins.json", "rstudio_bindings.json", "r.snippets")]
    rstudio_pref <- list[list %in% c("rstudio-prefs.json")]
    # Get full path
    keybind_path <-
      (glue::glue("{preference_path}/{keybinding_files}"))
    rstudio_pref_file <-
      (glue::glue("{preference_path}/{rstudio_pref}"))

    # Create directory
    fs::dir_create(glue::glue("{rstudio_pref_path}/keybindings"), recurse = TRUE)

    # Check that the files were copied correctly
    stopifnot(
      file.copy(keybind_path, glue::glue("{rstudio_pref_path}/keybindings"), overwrite = TRUE),
      file.copy(rstudio_pref_file, glue::glue("{rstudio_pref_path}"), overwrite = TRUE)
    )
    rstudio_pref_path_keybindings <- glue::glue("{rstudio_pref_path}/keybindings")
    cli::cli_alert_success("Sucessfully imported RStudio preferences.")
    cli::cli_alert_success("{.file {keybinding_files}} copied to {.path {rstudio_pref_path_keybindings}}", wrap = TRUE)
    cli::cli_alert_success("{.file {rstudio_pref}} copied to {.path {rstudio_pref_path}}.", wrap = TRUE)

    # Refresh RStudio to reload preferences, especially for themes
    if (interactive()) .rs.restartR()
  }


#' Import local preferences files to R Studio
#'
#' @param preference_path string: Relative folder_path where .json files are
#'   contained.
#'
#' @return Import addins.json, rstudio_bindings.json, r.snippets to the
#'   keybindings folder and rstudio-prefs.json to the RStudio folder
#' @export
#' @examples import_local_prefs("/rstudio_preferences")
import_local_prefs <-
  function(preference_path = "/rstudio_preferences") {
    pref_path <- glue::glue("{usethis:::rstudio_config_path()}")
    pref_files <- list.files(glue::glue("{here::here()}{preference_path}"))

    # List the file names and only add existing files
    # For example, r.snippets might not exist
    # use vector1[vector2] to only retain TRUE value.
    list <- list.files(glue::glue("{preference_path}"))
    keybinding_files <-
      list[list %in% c("addins.json", "rstudio_bindings.json", "r.snippets")]
    rstudio_pref <- list[list %in% c("rstudio-prefs.json")]

    # Get full path
    keybind_path <-
      (glue::glue("{here::here()}/{preference_path}/{keybinding_files}"))
    rstudio_pref_path <-
      (glue::glue("{here::here()}/{preference_path}/{rstudio_pref}"))

    # Get full pathnam
    list.files(glue::glue("{pref_path}/keybindings/"), full.names = TRUE)

    # Copy files
    fs::dir_create(pref_path, recurse = TRUE)
    fs::dir_create(glue::glue("{pref_path}/keybindings"), recurse = TRUE)
    fs::file_copy(keybind_path, glue::glue("{pref_path}/keybindings"), overwrite = TRUE)
    fs::file_copy(rstudio_pref_path, glue::glue("{pref_path}"), overwrite = TRUE)

    cli::cli_alert_success("Sucessfully imported RStudio preferences.")
    cli::cli_alert_success(glue("Files copied to {keybind_path})."), wrap = TRUE)
    cli::cli_alert_success(glue::glue("Files copied to {rstudio_pref_path}."), wrap = TRUE)
  }

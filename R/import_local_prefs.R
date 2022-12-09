
#' Import local preferences files to R Studio
#'
#' @param preference_path_name string: Relative folder_path where .json files are contained.
#'
#' @return Your settings are imported.
#' @export
#'
#' @examples import_local_prefs()
import_local_prefs <-
  function(preference_path_name = "rstudio_preferences") {
    pref_path <- glue("{usethis:::rstudio_config_path()}")
    pref_files <- list.files(glue("{here()}/{preference_path_name}/"))

    # List the file names and only add existing files
    # For example, r.snippets might not exist
    # use vector1[vector2] to only retain TRUE value.
    list <- list.files(glue("{preference_path_name}"))
    keybinding_files <-
      list[list %in% c("addins.json", "rstudio_bindings.json", "r.snippets")]
    rstudio_pref <- list[list %in% c("rstudio-prefs.json")]

    # Get full path
    keybind_path <-
      (glue("{here()}/{preference_path_name}/{keybinding_files}"))
    rstudio_pref_path <-
      (glue("{here()}/{preference_path_name}/{rstudio_pref}"))

    # Copy files
    fs::dir_create(pref_path, recurse = TRUE)
    fs::dir_create(glue::glue("{pref_path}/keybindings"), recurse = TRUE)
    file_copy(keybind_path, glue("{pref_path}/keybindings"), overwrite = TRUE)
    file_copy(rstudio_pref_path, glue("{pref_path}"), overwrite = TRUE)
    cli::cli_alert_success("Sucessfully imported RStudio preferences.")
    # TODO: Get \n on the string
    cli::cli_alert_success(glue("Files copied to {keybind_path}."), wrap = TRUE)
    cli::cli_alert_success(glue("Files copied to {rstudio_pref_path}."), wrap = TRUE)
  }

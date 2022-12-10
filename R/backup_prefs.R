
#' Backup of R Studio preferences.
#'
#' Copy rstudio_bindings.json, addins.json rstudio-bindings.json and r.snippets
#' to .bak in your R Studio config path.
#'
#'
#' @details Use `usethis:::rstudio_config_path()` to obtain your preference
#'   path.
#'
#' @param open_prefs_folder logical: TRUE or FALSE. Open the preference folder
#'   at the end of backing up for convenience.
#'
#' @return Copy rstudio_bindings.json, addins.json rstudio-bindings.json and
#'   r.snippets to .bak in your R Studio config path.
#' @export
#'
#' @examples backup_prefs(open_prefs_folder = FALSE)
#'
backup_prefs <- function(open_prefs_folder = FALSE) {
  # keybindings
  pref_path <- glue::glue("{usethis:::rstudio_config_path()}")
  if (fs::file_exists(glue::glue("{pref_path}/keybindings/rstudio_bindings.json"))) {
    fs::file_copy(
      glue::glue("{pref_path}/keybindings/rstudio_bindings.json"),
      glue::glue("{pref_path}/keybindings/rstudio_bindings.json.bak"),
      overwrite = TRUE
    )
    cli::cli_alert_success(
      "Backed up old {.file rstudio_bindings.json} to
        {.file {pref_path}/keybindings/rstudio_bindings.json.bak}."
    )
  }
  # addins
  if (fs::file_exists(glue::glue("{pref_path}/keybindings/addins.json"))) {
    fs::file_copy(
      glue::glue("{pref_path}/keybindings/addins.json"),
      glue::glue("{pref_path}/keybindings/addins.json.bak"),
      overwrite = TRUE
    )
    cli::cli_alert_success(
      "Backed up old {.file addins.json} to
          {.file {pref_path}/keybindings/addins.bak}."
    )
  }
  # rstudio-prefs
  if (fs::file_exists(glue::glue("{pref_path}/rstudio-prefs.json"))) {
    fs::file_copy(
      glue::glue("{pref_path}/rstudio-prefs.json"),
      glue::glue("{pref_path}/rstudio-prefs.json.bak"),
      overwrite = TRUE
    )
    cli::cli_alert_success(
      "Backed up old {.file rstudio-prefs.json} to
          {.file {pref_path}/rstudio-prefs.json.bak}."
    )
  }
  # snippets
  fs::dir_create(glue::glue("{pref_path}/snippets"), recurse = TRUE)
  if (fs::file_exists(glue::glue("{pref_path}/snippets/r.snippets"))) {
    fs::file_copy(
      glue::glue("{pref_path}/snippets/r.snippets"),
      glue::glue("{pref_path}/keybindings/r.snippets.bak"),
      overwrite = TRUE
    )
    cli::cli_alert_success("Backed up old {.file r.snippets} to
          {.file {pref_path}/r.snippets.bak}.")
  }
  if (open_prefs_folder == TRUE) {
    shell.exec(glue("{usethis:::rstudio_config_path()}"))
  }
}

#' Backup of R Studio preferences.
#'
#' Copy rstudio_bindings.json, addins.json rstudio-bindings.json and r.snippets
#' to .bak in your R Studio config path.
#'
#'
#' @param open_backup_path logical: TRUE or FALSE. Open the preference folder
#'   at the end of backing up for convenience.
#' @param rstudio_pref_path string: Default rstudio config path.
#'
#' @return Copy rstudio_bindings.json, addins.json rstudio-bindings.json and
#'   r.snippets to .bak in your R Studio config path.
#'
#' @examples backup_prefs(open_backup_path = FALSE)
#'
backup_prefs <-
  function(open_backup_path = FALSE,
           rstudio_pref_path = rstudio_config_path()) {
    pref_path <- glue::glue("{rstudio_pref_path}")

    # keybindings
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
        glue::glue("{pref_path}/snippets/r.snippets.bak"),
        overwrite = TRUE
      )
      cli::cli_alert_success("Backed up old {.file r.snippets} to
          {.file {pref_path}/r.snippets.bak}.",
        wrap = TRUE
      )
    }
    if (open_backup_path == TRUE) {
      shell.exec(glue("{rstudio_config_path()}"))
    }
  }

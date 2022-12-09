if (!requireNamespace("librarian", quietly = TRUE)) {
  install.packages("librarian")
}
librarian::shelf(glue, usethis, fs, cli, yesno, here)

pref_path <-
  backup_prefs <- function(pref_path = glue("{usethis:::rstudio_config_path()}"),
                           open_folder = FALSE) {
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
          {.file {pref_path}/keybindings/addins.json}."
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
    if (open_folder == TRUE) {
      shell.exec(glue("{usethis:::rstudio_config_path()}"))
    }
  }

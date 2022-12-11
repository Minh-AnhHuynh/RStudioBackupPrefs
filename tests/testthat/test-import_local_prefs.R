test_that("import_local_prefs() throws an error for unknown .json preference files", {
  temp_dir <- tempdir()
  # Call the function with an invalid preference path
  result <-
    # Check that the function throws an error
    expect_error(suppressMessages(import_local_prefs(preference_path = temp_dir)))
})

test_that("import_local_prefs() copies keybinding files to the correct location", {
  # Set up a dummy directory for the test
  temp_dir <- tempdir()
  rstudio_temp <- file.path(temp_dir, "rstudio_temp")
  # Create some dummy keybinding files
  fs::file_create(file.path(temp_dir, "addins.json"))
  fs::file_create(file.path(temp_dir, "rstudio_bindings.json"))
  fs::file_create(file.path(temp_dir, "r.snippets"))
  fs::file_create(file.path(temp_dir, "rstudio-prefs.json"))
  # Call the function with the dummy directory as the preference path
  suppressMessages(import_local_prefs(preference_path = temp_dir, rstudio_pref_path = rstudio_temp))
  # Check that the files were copied to the keybindings directory
  keybindings_dir <- file.path(rstudio_temp, "keybindings")
  expect_true(file.exists(file.path(keybindings_dir, "addins.json")))
  expect_true(file.exists(file.path(keybindings_dir, "rstudio_bindings.json")))
  expect_true(file.exists(file.path(keybindings_dir, "r.snippets")))
  expect_true(file.exists(file.path(rstudio_temp, "rstudio-prefs.json")))
})

test_that("copy_files_to_local() copies files to the local folder", {
  # Create a temporary directory
  temp_dir <- tempdir()

  # Set the preference path to the temporary directory
  preference_path <- file.path(temp_dir, "preferences")

  # Set up test data
  rstudio_bindings <- file.path(preference_path, "keybindings", "rstudio_bindings.json.bak")
  addins <- file.path(preference_path, "keybindings", "addins.json.bak")
  rstudio_prefs <- file.path(preference_path, "rstudio-prefs.json.bak")
  snippets <- file.path(preference_path, "snippets", "r.snippets.bak")
  fs::dir_create(file.path(preference_path, "keybindings"), recurse = TRUE)
  fs::dir_create(file.path(preference_path, "snippets"), recurse = TRUE)
  writeLines("test", rstudio_bindings)
  writeLines("test", addins)
  writeLines("test", rstudio_prefs)
  writeLines("test", snippets)

  # Run the copy_files_to_local() function
  copy_files_to_local(preference_path, rstudio_pref_path = preference_path)


  # Test that the copied files exist in the temporary directory
  expect_true(file.exists(file.path(preference_path, "addins.json")))
  expect_true(file.exists(file.path(preference_path, "r.snippets")))
  expect_true(file.exists(file.path(preference_path, "rstudio_bindings.json")))
  expect_true(file.exists(file.path(preference_path, "rstudio-prefs.json")))
})

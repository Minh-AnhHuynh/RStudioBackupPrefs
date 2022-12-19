test_that("copy_files_to_local() copies files to the local folder", {
  # Create a temporary directory
  temp_dir <- tempdir()

  # Set the preference path to the temporary directory
  preference_path <- file.path(temp_dir, "preferences")

  # Set up test data
  rstudio_bindings <- file.path(temp_dir, "keybindings", "rstudio_bindings.bak")
  addins <- file.path(temp_dir, "keybindings", "addins.bak")
  rstudio_prefs <- file.path(temp_dir, "rstudio-prefs.bak")
  snippets <- file.path(temp_dir, "snippets", "r.snippets.bak")
  fs::dir_create(file.path(temp_dir, "keybindings"), recurse = TRUE)
  fs::dir_create(file.path(temp_dir, "snippets"), recurse = TRUE)
  writeLines("test", rstudio_bindings)
  writeLines("test", addins)
  writeLines("test", rstudio_prefs)
  writeLines("test", snippets)

  # Run the copy_files_to_local() function
  copy_files_to_local(preference_path, rstudio_pref_path = temp_dir)


  # Test that the copied files exist in the temporary directory
  expect_true(file.exists(file.path(preference_path, "addins.json")))
  expect_true(file.exists(file.path(preference_path, "r.snippets")))
  expect_true(file.exists(file.path(preference_path, "rstudio_bindings.json")))
  expect_true(file.exists(file.path(preference_path, "rstudio-prefs.json")))
})

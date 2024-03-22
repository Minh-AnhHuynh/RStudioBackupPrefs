# Check that the preference files were removed correctly at the end if
# copy_to_local == FALSE and github_backup == TRUE

test_that("start_backup_prefs() removes the preference files correctly", {
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

  # Set up the git repo
  gert::git_init()
  gert::git_find()
  has_git_repository()

  # Run the start_backup_prefs() function
  start_backup_prefs(preference_path, copy_to_local = FALSE, github_backup = TRUE)

  # Test that the preference files were removed correctly
  expect_false(file.exists(rstudio_bindings))
  expect_false(file.exists(addins))
  expect_false(file.exists(rstudio_prefs))
  expect_false(file.exists(snippets))
})

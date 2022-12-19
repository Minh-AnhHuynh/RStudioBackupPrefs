test_that("backup_prefs creates backups of relevant files", {
  # Set up test data
  temp_dir <- tempdir()
  rstudio_bindings <- file.path(temp_dir, "keybindings", "rstudio_bindings.json")
  addins <- file.path(temp_dir, "keybindings", "addins.json")
  rstudio_prefs <- file.path(temp_dir, "rstudio-prefs.json")
  snippets <- file.path(temp_dir, "snippets", "r.snippets")
  fs::dir_create(file.path(temp_dir, "keybindings"), recurse = TRUE)
  fs::dir_create(file.path(temp_dir, "snippets"), recurse = TRUE)
  writeLines("test", rstudio_bindings)
  writeLines("test", addins)
  writeLines("test", rstudio_prefs)
  writeLines("test", snippets)

  # Run the test
  backup_prefs(rstudio_pref_path = temp_dir)
  expect_true(file.exists(paste0(rstudio_bindings, ".bak")))
  expect_true(file.exists(paste0(addins, ".bak")))
  expect_true(file.exists(paste0(rstudio_prefs, ".bak")))
  expect_true(file.exists(paste0(snippets, ".bak")))
})

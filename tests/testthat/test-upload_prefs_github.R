test_that("upload_prefs_to_github adds and commits files", {
  skip_if_not_installed("gert")
  skip_if_not_installed("withr")
  skip_if_not_installed("mockery")

  # Setup temporary git repo
  repo <- file.path(tempdir(), "testrepo")
  dir.create(repo, recursive = TRUE, showWarnings = FALSE)
  gert::git_init(repo)

  # Create preference path and dummy files
  pref_dir <- file.path(repo, "R/rstudio_preferences")
  dir.create(pref_dir, recursive = TRUE)
  pref_files <- c("rstudio-prefs.json", "rstudio_bindings.json")
  for (file in pref_files) {
    writeLines('{"key": "value"}', file.path(pref_dir, file))
  }

  # Mock user interactions and git_push
  withr::local_dir(repo)

  mock_yesno <- function(...) TRUE
  mock_git_push <- function(...) TRUE

  # Define a dummy check_json_existence
  check_json_existence <- function(...) TRUE

  mockery::stub(upload_prefs_to_github, "yesno::yesno", mock_yesno)
  mockery::stub(upload_prefs_to_github, "gert::git_push", mock_git_push)
  mockery::stub(upload_prefs_to_github, "check_json_existence", check_json_existence)

  # Run the function and check that commit occurs without error
  expect_error(
    upload_prefs_to_github(
      preference_path = "R/rstudio_preferences",
      git_message = "Test commit message"
    ),
    NA
  )

  # Confirm that git log shows a commit
  log <- gert::git_log(max = 1)
  expect_match(log$message, "Test commit message")
})

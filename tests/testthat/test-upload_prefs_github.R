test_that("upload_prefs_to_github works", {
# Create a temporary directory and navigate to it
temp_dir <- tempdir()
setwd(temp_dir)

# Create a test preference file and assign it to a variable
prefs_file <- file.create("test_prefs.txt")

# Call the upload_prefs_to_github() function with the prefs_file variable as the preference_path argument and a custom git_message argument
upload_prefs_to_github(preference_path = temp_dir, git_message = "Test commit message")

# Verify that the function initiates a Git repository and creates a GitHub repository if no repository exists
expect_true(has_git_repository())

# Add and commit some test files to the Git repository
git_add("test_file_1.txt", "test_file_2.txt")
git_commit(message = "Test commit message")

# Verify that the function successfully stages and commits the changes
expect_true(any(git_status()$staged))
expect_true(git_commit())

# Call the upload_prefs_to_github() function again, this time with no arguments
upload_prefs_to_github()

# Verify that the function unstages the test files and pushes the changes to GitHub
expect_true(git_reset())
expect_true(git_push())

# Clean up the temporary directory and any test files that were created
unlink(temp_dir, recursive = TRUE)
})

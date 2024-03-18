library(testthat)



test_that("import_from_github pulls from git repository when clone_git is TRUE or no git repository is found", {
  # Simulate the user entering a repository URL
  fake_readline <- function(...) "https://github.com/yourusername/yourrepo"

  # Mock readline function to simulate user input
  with_mocked_bindings(
    readline = fake_readline,
    {
      # Test when clone_git is TRUE
      result <- import_from_github(clone_git = TRUE)
      expect_true(file.exists("yourrepo"), "The repository should be cloned.")

      # Clean up cloned repository
      unlink("yourrepo", recursive = TRUE)
    }
  )

  # Test when there's no git repository and no URL provided
  result <- import_from_github()
  expect_true(file.exists("yourrepo"), "The repository should be cloned.")
  expect_true(has_git_repository(), "There should be a git repository after cloning.")

  # Clean up cloned repository
  unlink("yourrepo", recursive = TRUE)
})

test_that("import_from_github pulls from git repository when git_url is provided", {
  # Simulate the user entering a repository URL
  fake_readline <- function(...) "https://github.com/yourusername/yourrepo"

  # Mock readline function to simulate user input
  with_mock(
    readline = fake_readline,
    {
      # Test when git_url is provided
      result <- import_from_github(git_url = "https://github.com/yourusername/yourrepo")
      expect_true(file.exists("yourrepo"), "The repository should be cloned.")

      # Clean up cloned repository
      unlink("yourrepo", recursive = TRUE)
    }
  )
})

test_that("import_from_github pulls from git repository when clone_git is FALSE and git repository exists", {
  # Simulate the user entering a repository URL
  fake_readline <- function(...) "https://github.com/yourusername/yourrepo"

  # Mock readline function to simulate user input
  with_mock(
    readline = fake_readline,
    {
      # Test when clone_git is FALSE and git repository exists
      result <- import_from_github(clone_git = FALSE)
      expect_output(result, "Pull git repository.")

      # Clean up cloned repository
      unlink("yourrepo", recursive = TRUE)
    }
  )
})

copy_user_dictionary <- function(
  local_user_dict_path = "R/rstudio_preferences/",
  user_dic_path = get_user_dictionary_file()
) {
  # Copy the user dictionary
  fs::dir_create(local_user_dict_path)
  user_dic_path <- gsub("/", "\\\\", user_dic_path) # Make it prettier to print in cli
  fs::file_copy(path = user_dic_path, new_path = local_user_dict_path, overwrite = TRUE)
  cli::cli_alert_success(
    "User dictionary copied to {.path {local_user_dict_path}}",
    wrap = TRUE
  )
  # Write the number of words in the dictionary
  cli::cli_alert_info("There are {length(readLines(user_dic_path))} words in the user dictionary.")
}


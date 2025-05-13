# Import user dictionary

import_user_dictionary <- function(
    local_user_dict_path = "R/rstudio_preferences/",
    user_dic_path = get_user_dictionary_file()
) {
  # Copy the user dictionary
  user_dic_dir <- gsub( "user_dictionary", "", user_dic_path)
  user_dic_dir <- gsub("/", "\\\\", user_dic_dir) # Make it prettier to print in cli
  fs::dir_create(user_dic_dir)
  user_file <- glue::glue({local_user_dict_path}, "user_dictionary")
  fs::file_copy(path = user_file, new_path = user_dic_path, overwrite = TRUE)
  cli::cli_alert_success(
    "User dictionary copied to {.path {user_dic_dir}}",
    wrap = TRUE
  )
  # Write the number of words in the dictionary
  cli::cli_alert_info("There are {length(readLines(user_dic_path))} words in the user dictionary.")
}


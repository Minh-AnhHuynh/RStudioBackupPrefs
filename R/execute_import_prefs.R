
#' Start the backup process
#'
#' @return Function will start backing up your files in their folder to .bak and
#'   ask you if you want to back them up to github
#' @export
#'
#' @examples start_backup_prefs()
#'

start_backup_prefs <- function() {
  source("R/backup_prefs.R")
  local_prefs <- glue("{here()}/rstudio-preferences")
  backup_prefs()


  upload_choice <-
    yesno("Would you like to backup your files to your github repository ?")
  if (upload_choice == TRUE) {
    source("R/copy_to_local_prefs.R")
    source("R/upload_prefs_github.R")
    copy_files_to_local()
    upload_prefs_to_github()
  }
}


#' Start import
#'
#' @param pull_github boolean. Default is TRUE.
#'
#' @return Pull your github and import your preferences to the R Studio preference folder.
#' @export
#'
#' @examples start_import_prefs()
#'


start_import_prefs <- function(pull_github = TRUE) {
  if (pull_github == TRUE) {
    source("R/import_from_github.R")
  import_from_github()
  }
  source("R/import_local_prefs.R")
  import_local_prefs()
}

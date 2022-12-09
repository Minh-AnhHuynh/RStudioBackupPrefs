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

source("R/import_from_github.R")
import_from_github()
source("R/import_local_prefs.R")
import_local_prefs()

% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/copy_to_local_prefs.R
\name{copy_files_to_local}
\alias{copy_files_to_local}
\title{Copy backup files to a chosen local folder}
\usage{
copy_files_to_local(
  preference_path = "R/rstudio_preferences/",
  rstudio_pref_path = rstudio_config_path()
)
}
\arguments{
\item{preference_path}{string: Use a relative file path, don't add a "/" at
the end.}

\item{rstudio_pref_path}{string: Default RStudio preference path.}
}
\value{
Copy addins.json, r.snippets, rstudio_bindings.json, prefs.json to
folder in your working directory
}
\description{
Copy backup files to a chosen local folder
}
\examples{
copy_files_to_local()

}

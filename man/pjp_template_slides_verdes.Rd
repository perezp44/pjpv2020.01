% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pjp_template_slides_verdes.R
\name{pjp_template_slides_verdes}
\alias{pjp_template_slides_verdes}
\title{Call and open la plantilla para crear unas slides verdes}
\usage{
pjp_template_slides_verdes(
  name = "slides_xx_verdes",
  open = interactive(),
  ...
)
}
\arguments{
\item{name}{name of the slides file}

\item{open}{should the file be opened after being created}
}
\description{
Usar la plantilla para slides verdes
}
\examples{
\donttest{
if(interactive()){
  use_tidytemplate(name = "My_Awesome_TidyTuesday.Rmd")
}
}

}

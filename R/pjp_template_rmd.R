#' @title call and open la plantilla para crear un archivo .Rmd
#' @description Uuar la plantilla para crear un archivo .Rmd
#'
#' @param name name of your analysis file
#' @param open si estas en interactivo o no
#' @importFrom usethis use_template
#' @importFrom fs dir_create
#' @examples
#' pjp_template_rmd()pjp_template_rmd()

#' @export


pjp_template_rmd <- function(name = "titulito", open = interactive() ){
  use_template("archivo-rmd.Rmd", save_as = paste0(name, ".Rmd"), package = "pjpv2020.01", open = open)
  }

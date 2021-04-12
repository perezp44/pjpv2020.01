#' @title Call and open la plantilla para crear una bitacora
#' @description Usar la plantilla para bitacoras y empezar a documentar el Rproject
#' @param name name of your TidyTuesday analysis file
#' @param open should the file be opened after being created
#' @importFrom usethis use_template
#' @importFrom fs dir_create
#' @examples
#' \donttest{
#' if(interactive()){
#'   use_tidytemplate(name = "My_Awesome_TidyTuesday.Rmd")
#' }
#' }
#'
#' @export
pjp_template_bitacora <-
  function(name = NULL, open = interactive(), ... ) {
  use_template("bitacora.Rmd", save_as = "bitacora.Rmd",
               package = "pjpv2020.01", ... , open = open)
  fs::dir_create("./assets/")
  use_template("bitacora_pjp.css", save_as = "./assets/bitacora_pjp.css",
               package = "pjpv2020.01", ..., open = FALSE)
}

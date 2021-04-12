#' @title Call and open la plantilla para crear unas slides verdes
#' @description Usar la plantilla para slides verdes
#' @param name name of the slides file
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
pjp_template_slides_verdes <-
  function(name = "slides_xx_verdes.Rmd", open = interactive(), ... ) {
  use_template("slides_verdes.Rmd", save_as = name,
               package = "pjpv2020.01", ... , open = open)
  fs::dir_create("./assets/")
  use_template("slides_verdes.css", save_as = "./assets/slides_verdes.css",
               package = "pjpv2020.01", ..., open = FALSE)
  use_template("favicon-yo.html", save_as = "./assets/favicon-yo.html",
               package = "pjpv2020.01", ..., open = FALSE)
}

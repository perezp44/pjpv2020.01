# https://www.tidyverse.org/articles/2017/11/usethis-1.0.0/
# install.packages("usethis")  #- coge parte de devtools
#- usethis::use_usethis() #- para q se cargue el pkg usethis en Renviron (pero no lo hago)
#- use_course() #- esto lo has de probar para bajarte repos


#- Yo creo primero el Rproject y luego lo sobreescribo con create_package
library(usethis)

#---------------- has de elegir un nombre para el pkg
name_of_the_pkg <- "pjppkgRdata01"
path <- paste0("C:/Users/perezp/Desktop/a_GIT_2016a/", name_of_the_pkg)
create_package(path)

#---------------- FILL Pkg
use_roxygen_md()  #- sets up roxygen2 and enables markdown mode so you can use markdown in your roxygen2 comment blocks.
use_package_doc() #- creates a skeleton documentation file for the complete package, taking the advantage of the latest roxygen2 features to minimise duplication between the DESCRIPTION and the documentation
use_readme_rmd()  #- creates a README.Rmd: use this to describe what your package does and why people should care about it.
use_news_md()     #- creates a basic NEWS.md for you to record changes
use_mit_license(name = "Pedro J. Pérez")

#- Tendras que modificar a mano: DESCRIPTION , README.Rmd y NEWS.md

usethis::use_github()

usethis::use_github_labels()

#----------------  Vignette
my_name_vignette <- paste0("intro-to-", name_of_the_pkg)
use_vignette(my_name_vignette) #- sets you up for success by configuring DESCRIPTION and creating a .Rmd template in vignettes/


#--------------- GIT:  http://happygitwithr.com/github-pat.html#step-by-step
use_git()           #- activa GIT. se reinicia RStudio, asi q has de volver a hacer library(usethis)
edit_r_environ()  #- and use edit_r_environ() to easily access the right file for editing)
#use_github_links()
#--------------- Asi es como he generado el GIT token (http://happygitwithr.com/github-pat.html#step-by-step)
#- haciendo caso a Jenny he generado un new token en Github, concretamente en: https://github.com/settings/tokens
#- para ellos usethis::edit_r_environ()  y se abre .Renviron y he tenido q poner uan linea mascon:  GITHUB_PAT=número del token (q es un numero largito, 40)
#- Sys.getenv("GITHUB_PAT")(Con esta instrucción accedes al token)


use_github()         #-  activate github (te crea el repositorio)
use_github_labels()  #- labelling issues
use_github_links()   #- añade links en la file DESCRIPTION

#- queda poner el origin de Girhub (que me extraña que no este en usethis, pero no lo veo)
#- asi que toca hacerlo a mano en Bash
# git remote add origin https://github.com/perezp44/pjppkgdata01.git
# git push -u origin master


#- falta lo de CI (integracion continua tipo Travis)
use_coverage()  #



#--------------- easily create and/or edit important configuration files
#- Most functions have a scope argument which can be either “user” or “project”.
#- This lets you control the scope of your changes: either to the current project,
#- or for all projects for the current user (the default).
# edit_r_profile() #- R code run on start up
# edit_r_environ() #- environment variables
# edit_git_config()
# edit_git_ignore()

#--------------- set of functions lets you quickly jump to important websites
# browse_github()
# browse_github_issues()
# browse_travis()
# browse_cran()


use_()
use_data()   #- save package data in the correct format
use_data_raw()

#- 2020/01/02: voy a volver a hacer un R pkg y esto es lo que hice:
#- 2020/02/24: creo q este post me puede ayudar: https://rud.is/b/2020/01/03/writing-frictionless-r-package-wrappers-building-a-basic-r-package/
# PRIMERA PARTE: iniciando el repo  -----------------
# 0) Recuerda que NO has de crear antes el repo en Github

# 1) En la Consola de RStudio ejecuta `usethis::create_package("pjpv2020.01")` Se crea un Rproject con la estructura del pkg(la carpeta R, los archivos DESCRIPTION, NAMESPACE, etc ....)

# 2) una vez ya creado el Rproject que contiene al paquete, ejecutas en la CONSOLA: usethis::use_git(). Te dira que si haces el primer commit. Le dices que SI. Te dira si reinicias RStudio. le dices que SÍ

#--------------- GIT:  http://happygitwithr.com/github-pat.html#step-by-step
#--------------- GIT:  https://happygitwithr.com/rstudio-git-github.html     (mas nuevo!!!)
usethis::use_git()           #- activa GIT. te pregunta si haces el commit (le digo que NO). Se reinicia RStudio para q aparezca git pane

#- Para que cada commit que hagas no tengas que dar la contraseña, has de generar token en Github y despues meterlo en el el archivo . Renviron
#- Asi es como he generado el GIT token (http://happygitwithr.com/github-pat.html#step-by-step)
#- haciendo caso a Jenny he generado un new token en Github, concretamente en: https://github.com/settings/tokens
#- Una vez tienes el token haces `usethis::edit_r_environ()`
#- Se abrirá el archivo .Renviron y he tenido q poner una linea mas con:  GITHUB_PAT=número del token (q es un numero largito, 40)
#- Sys.getenv("GITHUB_PAT")(Con esta instrucción accedes al token)


# 3) Una vez RStudio se haya reiniciado, ejecutas en la CONSOLA: usethis::use_github()  . Te preguntará que qué git protocol quieres usar. Selecciona https. Te preguntará si la Descvription está OK. Le dices que SI. Se creará el repo en Github y añadirá el remote origin y alguna cosa mas y lo dejará casí niquelado.
usethis::use_github()


# SEGUNDA PARTE: tuneando -------------------------


# 1) Ya dentro del Rprojecto del pkg:

usethis::use_mit_license(name = "Pedro J. Pérez")
#usethis::use_package("tidyverse", "Suggests")     #- no buena idea xq es un meta-pkg
usethis::use_readme_md()                           #- modifica a tu gusto la README.md
usethis::use_news_md()                             #- tuneala

#- modificamos la DESCRIPTION
usethis::use_description(fields = list(Title = "Paquete de uso personal",
                                       `Authors@R` = 'person("Pedro", "Perez",
                                       email = "pedro.j.perez@uv.es",
                                       role = c("aut", "cre"))',
                                       Description = "Paquete para uso personal con algunas funciones y conjuntos de datos"))

#- para documentación
usethis::use_roxygen_md()  #- sets up roxygen2 and enables markdown mode so you can use markdown in your roxygen2 comment blocks.
usethis::use_package_doc() #- creates a skeleton documentation file for the complete package, taking the advantage of the latest roxygen2 features to minimise duplication between the DESCRIPTION and the documentation (crea el archivo ./R/<nombre-del-pkg>-package.R con
usethis::use_tibble()  #- If you want to avoid ugly data.frame printing for tibbles in your package,
usethis::use_github_links() #- Populates the URL and BugReports fields of a GitHub-using R package with appropriate links.


#usethis::use_github_labels()  #- labelling issues, para cambiar colores etc... (ptse. NO!!)

#- si quieres poner unit-tests
#usethis::use_test()   #- If you look into its source code, it’s really not that complex – but it does use a lot of cool helper functions!

#usethis::use_coverage()  #- falta lo de CI (integracion continua tipo Travis)



#---------------------- añadir a build ignore
usethis:use_build_ignore("_como_cree_el_pkg_v2.R")
usethis::use_build_ignore("./_f_en_curso/")
usethis::use_build_ignore("./_documentacion_old/")




# TERCERA PARTE: subiendo cambios a Github -------------------------

#--------------------- te vas a TERMINAL y haces esto para subir cambios (en realidad solo hace falta el git push)
git add -A
git commit --all --message "todo a Github"
git push -u origin master


# ANTIGUO (ya no lo uso, xq uso usethis::use_github())
#- queda poner el origin de Girhub (que me extraña que no este en usethis, pero no lo veo)
#- asi que toca hacerlo a mano en Bash
# git remote add origin https://github.com/perezp44/pjppkgdata01.git
# git push -u origin master


#- CUARTA PARTE: subir ficheros de datos (partiendo desde RAW) --------
usethis::use_data_raw()  #- crea un directorio "data-raw", y dentro crea un fichero DATASET.R. Ese fichero solo tiene la instrucción usethis::use_data("DATASET") para una vez creado DATASET, pues documentarlo etc....
#- una vez has creado la carpeta /data-raw/ , alli está un fichero que me crea los df que quiero exportar en la carpeta /data/
#- Recuerda que has de crear un fichero .R para cada df que quieras exportar (en la carpeta /R/)


#- QUINTA PARTE: crear un fichero para cada funcion que quieras expòrtar (en la carpeta /R/) ------
usethis::use_r("pjp_unique_values") #- para crear o modificar el fichero de la funcion



#- SEXTA PARTE: las dependencias --------------------------
usethis::use_package("purrr")
usethis::use_package("dplyr")
usethis::use_package("stringr")
usethis::use_package("magrittr")
usethis::use_pipe()   #---------------------------------------- JEY!!!!
#use_package("tibble") #- ya estab eb IMPORTS



#- SEPTIMA:: y super importante!!!! ------------------
devtools::document()  #- para que genere la documentacion de las funciones




#- OCTAVA: Cuando quieras añadir un nuevo conjunto de datos al pkg ---------------------
#- PARA AÑADIR un nuevo df u objeto:
#- 1) Cargas el objeto en memoria de R con un archivo de ./data-raw/
#- 2) Para q vaya a memoria del pkg has de: devtools::use_data(CNIG_CCAA_sf, overwrite = TRUE) #
#- 3) Añadir la documentacion creando un fichero roxygen en ./R/mis_datos.R
#- 4) Finalmente has de actualizar la documentacion con: devtools::document()
#- 5) Llevarlo a Github



#- NOVENA: Cuando quieras añadir una nueva f. al pkg --------------------------
#- 1) Añadir el fichero con la definicion de la f en : ./R/my_funcion.R
#- 3) En ese fichero ya pones la documentacion y si lo exportas con @export
#- 4) Finalmente has de actualizar la documentacion con: devtools::document()
#- 5) Llevarlo a Github




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




# Vignettes ------------------

my_name_vignette <- paste0("intro-to-", name_of_the_pkg)
use_vignette(my_name_vignette) #- sets you up for success by configuring DESCRIPTION and creating a .Rmd template in vignettes/

my_name_vignette2 <- paste0("detailed-info-", name_of_the_pkg)
use_vignette(my_name_vignette2) #- sets you up for success by configuring DESCRIPTION and creating a .Rmd template in vignettes/


#- Has de poner en el yaml de la vignette
# title: "Intro to spanishRshapes package"
# author: "Pedro J. Pérez"
# %\VignetteIndexEntry{Intro to spanishRshapes package}

#--------------------  README
#------ has de knittear README.Rmd para que aparezca README.md q es la que se muestra en Github por defecto


#--------------------- LA VIGNETTE
use_build_ignore("./vignettes/info_vignettes.txt")




#--------------------- te vas a TERMINAL y haces
# git add -A
# git commit --all --message "todo a Github"
# git push -u origin master
#git remote add origin https://github.com/perezp44/spanishLAU2rboundaries.git






#--------------------------- Ahora ya toca meter datos y arreglar documentación
#--------------------------- Ahora ya toca meter datos y arreglar documentación


#--------------------  README
#------ has de knittear README.Rmd para que aparezca README.md q es la que se muestra en Github por defecto

devtools::build_vignettes()  #- viñetas

devtools::document()         #- procesa los roxygen comments y las vignettes




# MAS COSAS ------------------------------
# Para despues correrlo

devtools::check(cran = FALSE)            #- chequea
devtools::check()           #- chequea

devtools::build()



#--------------------   Github
# git remote add origin https://github.com/perezp44/mypkgfordata.git
# cd c:/Users/perezp/Desktop/a_GIT_2016a/mypkgDataforblog
# git add -A    # stages all files
# git commit --all --message "Creando el REPO"
# git push -u origin master


#----------------- Licencia
# En esta pagina pone esto de licencia
# http://opendata.esri.es/datasets/d8854f26fd5c4baab08337ca0f3aff6f_0#
#Licencia (compatible con CC-BY 4.0) ampara el uso libre y gratuito para cualquier propósito legítimo,
#siendo la única estricta obligación la de reconocer y mencionar el origen y propiedad de los productos
#y servicios de información geográfica licenciados como del IGN según se indica en la licencia.
#Créditos: © Instituto Geográfico Nacional



#------- BADGES
install.packages("badgecreatr")
badgecreatr::badgeplacer( githubaccount = "perezp44",githubrepo = "spanishRshapes", branch = "master")
badgecreatr::badgeplacer(location = ".", status = "wip" , githubaccount = "perezp44",githubrepo = "spanishRshapes", branch = "master")




#------- PKGDOWN
devtools::install_github("hadley/pkgdown")
pkgdown::build_site()




#- segunda viñeta
library(usethis)

use_vignette("Info-detallada-LAU2boundaries4spain") #- sets you up for success by configuring DESCRIPTION and creating a .Rmd template in vignettes/
#- Has de poner en el yaml de la vignette
# title: "Intro to spanishRshapes package"
# author: "Pedro J. Pérez"
# %\VignetteIndexEntry{Intro to spanishRshapes package}

browseVignettes("LAU2boundaries4spain")

#--- comprimir datos
#Whenever you need to save a lot of R data,
# add `compress = "xz"` to the `save()` call.
#In my case it reduced the out-file size from 72MB to 3MB! No kidding =)


#-  consejos de Maelem
# http://www.masalmon.eu/2017/06/17/automatictools/?utm_content=buffere260d&utm_medium=social&utm_source=twitter.com&utm_campaign=buffer

lintr::lint_package()
devtools::spell_check()
devtools::release()

#- Thanking Your Reviewers: Gratitude through Semantic Metadata (https://ropensci.org/blog/2018/03/16/thanking-reviewers-in-metadata/)
person("Bea", "Hernández", role = "rev",
       comment = "Bea reviewed the package for rOpenSci, see
       https://github.com/ropensci/onboarding/issues/116")


# [[How to push large files to GitHub y BORRAR]](https://medium.com/@AyunasCode/how-to-push-large-files-to-github-253d05cc6a09). Cuando borar una file del repo, aun queda esa file en el Git. hay que quitarla!!








#- Un post GOOD: https://www.hvitfeldt.me/blog/usethis-workflow-for-package-development/


#- https://www.rostrum.blog/2019/12/27/pkgs-2019/
#- use_r() to create in the right place an R script for your functions
#- use_vignette() and use_readme_md() for more documentation
#- use_testthat() and use_test() for setting up tests
#- use_package() to add packages to the Imports section of the DESCRIPTION file
#- use_data() and use_data_raw() to add data sets to the package and the code used to create them
#- There are also other flavours of function like git_*() and pr_*() to work with version control and proj_*() for working with RStudio Projects.

#- Sharla
#usethis::use_data_raw()
#usethis::use_data(delay_codes)
#usethis::use_r("setup")   #- para crear una funcion llamada setup()
#- And when I build my package (command + shift + L, command + shift + D, and command + shift + B are your best friends), delay_codes is actually an object available in the package!










# YY: Biblio: -----------------------------------------------------------------------

# Web del pkg usethis: https://usethis.r-lib.org/

#- un post de Enero de 20020: https://www.r-bloggers.com/writing-frictionless-r-package-wrappers-building-a-basic-r-package/  (de Bob Rudis). Tiene una precuela: https://rud.is/b/2020/01/01/writing-frictionless-r-package-wrappers-introduction/ y un bookdown: https://rud.is/books/writing-frictionless-r-package-wrappers/

# Curso de Colin Fay: https://github.com/ColinFay/erum2018

# Post q hace un pkg para hacer informes periodicos: https://sharla.party/post/usethis-for-reporting/


# ZZ: Usar el pkg pjpv2020.01 -----------------------------------------------------------------------------------------------
# - z.1 instalar el paquete pjpv2020.01 --------------
remotes::install_github("perezp44/pjpv2020.01")
library(pjpv2020.01)
df <- pjp_data_pob_mun_1996_2019

# - z.2 usar las funciones de pjpv2020.01 package --------------
zz <- df %>% pjp_f_estadisticos_basicos()

zz1 <- df %>% pjp_f_unique_values()
zz2 <- df %>% pjp_f_valores_unicos(nn_pjp = 40)

df <- pjp_data_cod_mun_INE
df <- pjp_data_cod_prov_INE

xx <- pjp_f_decimales(iris)

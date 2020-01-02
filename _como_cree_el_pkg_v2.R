#- 2020/01/02: voy a volver a hacer un R pkg y esto es lo que hice:

# PRIMERA PARTE: iniciando el repo  -----------------
# 0) Recuerda que NO has de crear antes el repo en Github

# 1) En la Consola de RStudio ejecuta `usethis::create_package("pjpv2020.01")` Se crea un Rproject con la estructura del pkg(la carpeta R, los archivos DESCRIPTION, NAMESPACE, etc ....)

# 2) una vez ya creado el Rproject que contiene al paquete, ejecutas en la CONSOLA: usethis::use_git(). Te dira que si haces el primer commit. Le dices que SI. Te dira si reinicias RStudio. le dices que SÍ

# 3) Una vez RStudio se haya reiniciado, ejecutas en la CONSOLA: usethis::use_github()  . Te preguntará que qué git protocol quieres usar. Selecciona https. Te preguntará si la Descvription está OK. Le dices que SI. Se creará el repo en Github y añadirá el remote origin y alguna cosa mas y lo dejará casí niquelado.




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

#- si quieres poner unit-tests
#usethis::use_test()   # If you look into its source code, it’s really not that complex – but it does use a lot of cool helper functions!


#--------------- GIT:  http://happygitwithr.com/github-pat.html#step-by-step
#--------------- GIT:  https://happygitwithr.com/rstudio-git-github.html     (mas nuevo!!!)
usethis::use_git()           #- activa GIT. te pregunta si haces el commit (le digo que NO). Se reinicia RStudio para q aparezca git pane

#- Para que cada commit que hagas no tengas que dar la contraseña, has de generar token en Github y despues meterlo en el el archivo . Renviron
#- Asi es como he generado el GIT token (http://happygitwithr.com/github-pat.html#step-by-step)
#- haciendo caso a Jenny he generado un new token en Github, concretamente en: https://github.com/settings/tokens
#- Una vez tienes el token haces `usethis::edit_r_environ()`
#- Se abrirá el archivo .Renviron y he tenido q poner una linea mas con:  GITHUB_PAT=número del token (q es un numero largito, 40)
#- Sys.getenv("GITHUB_PAT")(Con esta instrucción accedes al token)


#usethis::edit_r_environ()  #- to easily access the right file for editing)


#usethis::use_github_links() #- Populates the URL and BugReports fields of a GitHub-using R package with appropriate links.



#usethis::use_github()         #-  activate github (te crea el repositorio)
use_github_labels()  #- labelling issues
use_github_links()   #- añade links en la file DESCRIPTION

#- queda poner el origin de Girhub (que me extraña que no este en usethis, pero no lo veo)
#- asi que toca hacerlo a mano en Bash
# git remote add origin https://github.com/perezp44/pjppkgdata01.git
# git push -u origin master


#- falta lo de CI (integracion continua tipo Travis)
use_coverage()  #


usethis::use_github()

usethis::use_github_labels()








usethis::use_git()                              #- t pregunta si haces el commit y dije que SI






#- Sharla
#usethis::use_data_raw()
#usethis::use_data(delay_codes)
#usethis::use_r("setup")   #- para crear una funcion llamada setup()
#- And when I build my package (command + shift + L, command + shift + D, and command + shift + B are your best friends), delay_codes is actually an object available in the package!










# Biblio: -------------


# Web del pkg usethis: https://usethis.r-lib.org/

# Curso de Colin Fay: https://github.com/ColinFay/erum2018

# Post q hace un pkg para hacer informes periodicos: https://sharla.party/post/usethis-for-reporting/





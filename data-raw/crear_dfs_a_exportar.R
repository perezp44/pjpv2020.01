#---- This file documents  datasets inside the package pjpv2020.01
#- Included datasets:
#- 0) df_prueba : es solo un df para probar mis funciones. Tiene columnas de diversas clases (integer, bool etc...) es para probar las funciones. Quizas faltaria ponerle una columna con vectores o dfs

#- 1) pob_mun_1996_2019: cifras de poblacion municipal del INE. Tiene datos de 1996, (1998-2019) y para 3 categorias de la v. población : {Total, Hombres y Mujeres}

#- 2) cod_mun_INE: códigos municipales del INE (sacados del fichero anterior). Tiene 2 variables que indican cuando se "creo" el municipio (year_first) y si el municipio aun existe (year_last).

#- 3) cod_prov_INE: códigos provinciales del INE (sacados del fichero anterior)





library(tidyverse)
#- 1) cifras de población municipal del INE. Aquí solo cargo el fichero. En su día creé el fichero con el script "./INE_pob-muni/01_arreglar_datos_pob-muni_v1.R". Está al final de este script

ruta_al_fichero <- here::here("data-raw", "pob_mun_1996_2019.csv")
df <- readr::read_csv(ruta_al_fichero)
pjp_data_pob_mun_1996_2019 <- df


#usethis::use_data(pjp_data_pob_mun_1996_2019, overwrite = TRUE)  #- los datos se graban en /data/



#- 2) voy a crear un fichero con los códigos municipales
df <- pjp_data_pob_mun_1996_2019 %>% select(-c(poblacion, pob_values))
df <- df %>% group_by(INECodMuni) %>%
             mutate(year_first = min(year, na.rm = TRUE)) %>%
             mutate(year_last = max(year, na.rm = TRUE)) %>% ungroup()
df <- df %>% group_by(INECodMuni) %>% filter(year == max(year, na.rm = TRUE)) %>% distinct() %>% ungroup() %>% select (-year)

pjp_data_cod_mun_INE <- df
#usethis::use_data(pjp_data_cod_mun_INE, overwrite = TRUE)  #- los datos se graban en /data/
#- Por ejemplo, el municipio "Darrical" solo aparece el año 1996, asíque su first_year = 1996 y su year_last = 1996
#- Por ejemplo, el municipio 41904	"Palmar de Troya, El" solo aparece en 2019 xq se creó ese año, asi que su year_first = 2019


#- 3) Voy a crear dodigos provinciales

df <- pjp_data_cod_mun_INE %>% select(INECodProv, INECodProv.n, INECodCCAA, INECodCCAA.n) %>% distinct()

pjp_data_cod_prov_INE <- df
#usethis::use_data(pjp_data_cod_prov_INE, overwrite = TRUE)  #- los datos se graban en /data/
















################# --------------------------------- ##############################

#- Hacia abajo está el script original que utilice en su dia para crear el fichero "pob_mun_1996_2019.csv"
#- Aquí no funciona x pbs con las rutas,

#----- Script original está en: "./INE_pob-muni/01_arreglar_datos_pob-muni_v1.R" --------------------------------

#- Datos INE: poblacion por municipios
#- Revisión del Padrón Municipal a 1 de enero de 2019 (aprobadas por RD 743/2019) http://www.ine.es/dyngs/INEbase/es/operacion.htm?c=Estadistica_C&cid=1254736177011&menu=resultados&idp=1254734710990
#- De está dirección me fui a "Detalle municipal" y me baje un fichero comprimido: https://www.ine.es/pob_xls/pobmun.zip donde hay un fichero Excel para cada año, desde 1996 hasta 2018

#- Plan: voy a descomprimir el archivo en el directorio `tmp`
library(tidyverse)
library(fs)


# creo directorio temporal y descomprimo el archivo pobmun.zip ------------------------------------
# fs::dir_delete("tmp")
path_tmp_dir <- "tmp/pobmun"
fs::dir_create(path_tmp_dir)
unzip(zipfile = here::here("datos_in", "pobmun.zip"),
      exdir = path_tmp_dir)

# ver cuantos ficheros hay y su nombre -----------------------
files <- dir(path_tmp_dir)   #- 23 ficheros: años 1996 a 2019 (falta 1997, no esta en el INE)

#- Pb: Resulta que los ficheros se llaman igual pero el año tiene solo 2 digitos
# cambiar el nombre de los ficheros  -------------------------
files_new <- str_remove(files, "^pobmun")

ff_empieza_por <- function(xx) {
    if (str_detect(xx, "^9")) {xx <- paste0("19", xx)}
    else {xx <- paste0("20", xx)}
}
files_new <- map_chr(files_new, ff_empieza_por)


files_rr <- dir(path_tmp_dir, full.names = TRUE)     #- para poder cambiarles el nombre me hace falta la ruta
files_rr_new <- paste0(path_tmp_dir, "/", files_new) #- la nueva ruta-nombre
# cambio nombre de fichero para ponerle como nombre solo el año
file_move(files_rr, files_rr_new) #- ok las filas ya se llamas 1996.xlsx .... 2005.xls,  ... 2019.xlsx

rm(files, files_new, files_rr, files_rr_new)

#- cargo TODOS los ficheros, PERO resulta que su estructura (gracias INE!!!!) no es homogenea:
rutas_a_ficheros <- fs::dir_ls(here::here(path_tmp_dir))
df_list <- map(rutas_a_ficheros, readxl::read_excel, skip = 1) #-

#- He de arreglar las pifias del INE:
#- pifia_1) el  año 1998 no tiene linea introductoria en la cabecera
df_list[[2]] <- readxl::read_excel(rutas_a_ficheros[2])
#- pifia_2) los años 2012, 2013, 2014, 2015 y 2017 tenian 2 lineas introductorias en la cabecera,
zz_mal <- c(16, 17, 18, 19, 21)
for (ii in zz_mal) {
    df_list[[ii]] <- readxl::read_excel(rutas_a_ficheros[ii], skip = 2)
}

#- puedes verlo con:  map(df, names) que ya estan casi bien
#- pifia_3) los 3 años q empiezan x 19..: 1996, 1998 y 1999 tienen una variable menos, les falta el nombre de la Provincia
zz_mal <- c(1,2,3)
for (ii in zz_mal) {
    df_list[[ii]] <- df_list[[ii]] %>% mutate(PROVINCIAx = NA_character_) %>% select(1, PROVINCIAx, everything())
}
rm(zz_mal)
#- map(df, names)

#- pifia_4) los ficheros de 2002, 2007, 2009  tienen filas con los totales de las provincias
#- ademas, el fichero de 2016 tiene una fila para el total de la poblacion española
#- df_list[[6]] <- df_list[[6]] %>% filter(!is.na(CMUN)) #- lo arreglare luego mas abajo xq lo puedo hacer todos a la vez


#- Añadir una columna con el año
zz_anyos <- c(1996, 1998:2019)

for (ii in 1:length(df_list)) {
    df_list[[ii]] <- df_list[[ii]] %>% mutate(year = zz_anyos[ii])
}

#- unificar los nombres de las columnas
names_ok <- c("CPRO", "PROVINCIA", "CMUN", "MUNICIPIO", "pob_Total", "pob_Hombres", "pob_Mujeres", "year")

for (ii in 1:length(df_list)) {
    names(df_list[[ii]]) <- names_ok
}

#- Fusionar los 23 ficheros
df_ok <- df_list[[1]]
for (ii in 2:length(df_list)) {
    df_ok <- bind_rows(df_ok, df_list[[ii]])
}

#- la verdad es que se puede fusionar bastante mas rápido
df_ok_2 <- map2_df(df_list, zz_anyos, ~ mutate(.x, year2 = .y))  #- https://stackoverflow.com/questions/42028710/add-new-variable-to-list-of-data-frames-with-purrr-and-mutate-from-dplyr

#- arreglo la pifia nº 4)
df_ok <- df_ok %>% filter(!is.na(CMUN))
df_ok_2 <- df_ok_2 %>% filter(!is.na(CMUN))




#- limpiar el entorno
fs::dir_delete(path_tmp_dir)      #- borrar el directorio temporal
zz <- c("df_list", "df_ok")
rm(list= ls()[!(ls() %in% zz)])   #- remueve todo excepto zz

#---------------------------------------------------------------------------------------
#- voy a hacer el fichero LARGO
df <- pivot_longer(df_ok,
                   cols = starts_with("pob_"),
                   names_to = "poblacion",
                   names_prefix = "pob_",
                   values_to = "pob_values")

df <- df %>% select(- PROVINCIA) %>% rename(MUNICIPIO.orig = MUNICIPIO)
#- aun me di cuenta de otra pifia: alghuna veces (en el fichero de 1998) el CMUN tiene 4 codigos (hay que quitar el ultimo)
df <- df %>% mutate(CMUN = str_extract(CMUN, "^.{3}")) #- me quedo con los 3 primeros digitos

#- codigo municipal de 5 digitos
df <- df %>% mutate(INECodMuni = paste0(CPRO, CMUN))


#- pongo nombre de las provincias (uso el fichero del ultimo año)
df_ultimo <- df_list[[length(df_list)]]
nombre_prov <- df_ultimo %>% select(CPRO, PROVINCIA) %>% distinct()
df <- left_join(df, nombre_prov, by = c("CPRO" = "CPRO"))
zz <- df %>% filter(is.na(PROVINCIA)) #- asi es como me di cuenta de la pifia nº 4 (que ya esta arreglada)


#- ahora vamos a ir poniendo el nombre de los municipios
nombre_muni_2019 <- df_ultimo %>% select(CPRO, CMUN, MUNICIPIO) %>% distinct()

df <- left_join(df, nombre_muni_2019, by = c("CPRO" = "CPRO", "CMUN" = "CMUN"))

#- pero ahora tb habran CMUN sin su nombre (x creacion, separacionn etc...)
zz <- df %>% filter(is.na(MUNICIPIO)) #- asi es como me di cuenta de la pifia nº 4
zz <- df %>% filter(MUNICIPIO.orig != MUNICIPIO) #- hay muchos xq hay muchos municipios que han cambiado de nombre
zz_1 <- df %>% filter(is.na(MUNICIPIO)) %>% distinct(MUNICIPIO.orig, MUNICIPIO)#- estos son los 5 municipios que han desaparecido

#- 1) Darrical: desaparecio en 1997 (se incorporo a Alcolea, provincia de Almeria)
#- 2) Cesuras: desaparecio en 2014 (se incorporo a Oza-Cesuras, provincia de A Coruña)
#- 3) Oza dos Ríos: desaparecio en 2014 (se incorporo a Oza-Cesuras, provincia de A Coruña)
#- 4) Cerdedo: desaparecio en 2017 (se incorporo a Cerdedo-Cotobade, provincia de Pontevedra)
#- 5) Cotobade: desaparecio en 2017 (se incorporo a Cerdedo-Cotobade, provincia de Pontevedra)


#- a estos 5 municipios les voy a poner su nombre en el año que desaparecieron, pero como no cambiaron de nombre no hay que calentarse el cap, con poner NOMBRe.orig suficiente
zz_1 <- df %>% filter(is.na(MUNICIPIO)) #- estos son los 5 municipios que han desaparecido
df <- df %>% mutate(MUNICIPIO = ifelse(is.na(MUNICIPIO), MUNICIPIO.orig, MUNICIPIO))

#- quiero poner el código y nombre provincial, y si es capital de provincia

library(spanishRpoblacion)
INE_ccaa  <- INE_padron_muni_96_17 %>% select(INECodProv, INECodCCAA, NombreCCAA) %>% distinct()
df <- left_join(df, INE_ccaa, by = c("CPRO"= "INECodProv"))
names(df)
df <- df %>% rename(INECodProv = CPRO) %>%
             rename(NombreProv = PROVINCIA) %>%
             rename(NombreMuni = MUNICIPIO) %>%
             select(-c(CMUN, MUNICIPIO.orig))

INE_capitales_prov <- INE_padron_muni_96_17 %>% select(INECodMuni, capital_prov) %>% distinct() %>% filter(capital_prov == 1) %>% pull(INECodMuni)
df <- df %>% mutate(capital_prov = ifelse(INECodMuni %in% INE_capitales_prov, 1, 0))

df <- df %>% select(year, INECodMuni, NombreMuni, capital_prov,INECodProv, NombreProv, INECodCCAA, NombreCCAA,  poblacion, pob_values)


#- PUES parece que YA LO TENGO!!!!
#- recuerda que INECodMuni es el nombre de 2019 (salvo para los 5 pueblos que han desaparecido, que es el nombre que tenian cuando desaparecieron)


#- voy a añadir las capitales de CCAA
#zz <- df %>% filter(capital_prov == 1) %>%  select(-c(year, poblacion, pob_values)) %>% distinct() %>% select(INECodMuni, NombreMuni)
#zz <- df %>% filter(NombreMuni %in% c("Vitoria-Gasteiz", "Santiago de Compostela", "Mérida"))


#- en Canarias tienen capitalidad compartida Tenerife y Las palmas
capitales_CCAA <- c(Sevilla = "41091", Zaragoza = "50297", Oviedo = "33044", Palma = "07040", Tenerife = "38038", Canarias = "35016", Santander = "39075", Toledo = "45168", Valladolid = "47186", Barcelona = "08019", Madrid = "28079", Murcia = "30030", Valencia = "46250", Merida = "06083", Santiago = "15078", Logroño = "26089", Pamplona = "31201", Vitoria = "01059")
capitales_CCAA <- as.data.frame(capitales_CCAA) %>% mutate(capital_CCAA = 1) %>% mutate(capitales_CCAA = as.character(capitales_CCAA))
str(capitales_CCAA)
df <- left_join(df,capitales_CCAA, by = c("INECodMuni" = "capitales_CCAA") )
df <- df %>% mutate(capital_CCAA = ifelse(is.na(capital_CCAA), 0 , 1))


#- voy a renombrar las variables
df <- df %>% rename(INECodMuni.n = NombreMuni) %>%
             rename(INECodProv.n = NombreProv) %>%
             rename(INECodCCAA.n = NombreCCAA)


#- voy a reordenar las variables
df <- df %>% select(year, INECodMuni, INECodMuni.n, capital_prov, capital_CCAA, INECodProv, INECodProv.n, INECodCCAA, INECodCCAA.n, everything())






#- GUARDO el fichero de datos de pob_munin ---------------------------------------------
#- GUARDO el fichero de datos de pob_munin ---------------------------------------------

#readr::write_csv(df, here::here("datos_out", "pob_mun_1996_2019.csv"))
#readr::write_rds(df, here::here("datos_out", "pob_mun_1996_2019.rds"))


#- limpio tmp
# fs::dir_delete("tmp")

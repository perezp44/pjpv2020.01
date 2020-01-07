
'%!in%' <- function(x,y)!('%in%'(x,y))  #- esta f. es not_in

# Son 3 funciones para calcular medias , NN, y % de variables por grupos 
# MYS funciones -----------------------------------------------------


#- FUNCION para crear tablas cruzadas con la media ponderada de una variable
#- VERSION 6: ya puedes poner varias variables en group_by
#- https://stackoverflow.com/questions/44169505/grouping-on-multiple-programmatically-specified-vars-in-dplyr-0-6?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa
# v_group y v_analizar van con !!! y entonces has de poner "
# v_factor va con !!, asi que al llamar a la funcion has de quo()

library(rlang)

my_f_mean_w <- function(df, v_group, v_analizar, v_factor){
  aa <- v_group[length(v_group)]
  df_rr <- df %>% group_by(!!! syms(v_group)) %>% 
    #summarise(NN_casos = n(), NN_pob = sum(!!v_factor), mean_w = weighted.mean(!!! syms(v_analizar), !! v_factor  ) )
    summarise( mean_w = weighted.mean(!!! syms(v_analizar), !! v_factor , na.rm = TRUE )  )
  df_rr <- df_rr %>% spread(aa, mean_w)
}

#- media de la v_analizar por grupos cruzados de las variables en v_group
# v_group <- c("estudios", "edad_x") #- las v. de GROUPING      (has de poner las v. entre "")
# v_analizar <- "salud"              #- la variable a ANALIZAR  (has de poner las v. entre "")
# zz <- my_f_mean_w(df, v_group, v_analizar, quo(factor))  


#- FUNCION para crear tablas cruzadas con el numero de gente en cada grupo

my_f_number_w <- function(df, v_group, v_analizar, v_factor){
  df_rr <- df %>% group_by(!!! syms(v_group)) %>% 
    summarise(NN_casos = n(), NN_pob = sum(!!v_factor), mean_w = weighted.mean(!!! syms(v_analizar), !! v_factor , na.rm = TRUE ) )
  df_rr
}
# numero de "personas" (en la poblacion y en la muestra) en cada caso de v_analizar en cada uno de los grupos en v_group
# v_group <- c("estudios", "edad_x", "salud") #- las v. de GROUPING      (has de poner las v. entre "")
# v_analizar <- "salud"              #- la variable a ANALIZAR  (has de poner las v. entre "")
# zz <- my_f_number_w(df, v_group, v_analizar, quo(factor))


#- FUNCION para crear tablas cruzadas con el % de gente en cada grupo de la v_analizar

my_f_percent_w <- function(df, v_group, v_analizar, v_factor){
  v_group_2 <- v_group[1:(length(v_group))-1]   #- lquito la ultima v. de grouping para el ultimo paso en que calculo los %
  df_rr <- df %>% group_by(!!! syms(v_group)) %>% 
    summarise(NN_casos = n(), NN_pob = sum(!!v_factor), mean_w = weighted.mean(!!! syms(v_analizar), !! v_factor  ) ) %>% 
    ungroup() %>% 
    group_by(!!! syms(v_group_2)) %>% mutate(percent = NN_pob/sum(NN_pob)*100)
  df_rr
}
# porcentaje de "personas" (en la poblacion) y nº de casos (en la muestra y en la poblacion) en cada categoria de v_analizar en cada uno de los grupos en v_group
# v_group <- c("estudios", "edad_x", "salud") #- las v. de GROUPING  (tb has de poner la v. sobre la q quieres obtener los calculos)    (has de poner las v. entre "")
# v_analizar <- "salud"                       #- la variable a ANALIZAR  (has de poner las v. entre "")
# xx <- v_group[1:(length(v_group))-1]
# zz <- my_f_percent_w(df, v_group, v_analizar, quo(factor)) 
# zza <- decimales_df_pjp(as.data.frame(zz))




#- FUNCION para crear tablas cruzadas con el % de gente en cada grupo de la v_analizar

my_f_percent_w_na <- function(df, v_group, v_analizar, v_factor){
 df <- df %>% select(!!! syms(v_group),!!v_analizar, !! v_factor ) %>% filter(complete.cases(.)) #-quito los nas
  #df <- df %>% select(!!! syms(v_group),!!v_analizar, !! v_factor ) %>% filter(! is.na(!! v_analizar))  #-quito los nas
  
  v_group_2 <- v_group[1:(length(v_group))-1]   #- le quito la ultima v. de grouping para el ultimo paso en que calculo los %

  df <- df %>% group_by(!!! syms(v_group)) %>% 
    summarise(NN_casos = n(), NN_pob = sum(!!v_factor), mean_w = weighted.mean(!!! syms(v_analizar), !! v_factor ,na.rm = TRUE ) ) %>% ungroup()
  
  df <- df %>% 
    group_by(!!! syms(v_group_2)) %>% mutate(percent = NN_pob/sum(NN_pob)*100) %>% ungroup()
  df
}
# porcentaje de "personas" (en la poblacion) y nº de casos (en la muestra y en la poblacion) en cada categoria de v_analizar en cada uno de los grupos en v_group
# v_group <- c("estudios", "edad_x", "salud") #- las v. de GROUPING  (tb has de poner la v. sobre la q quieres obtener los calculos)    (has de poner las v. entre "")
# v_analizar <- "salud"                       #- la variable a ANALIZAR  (has de poner las v. entre "")
# xx <- v_group[1:(length(v_group))-1]
# zz <- my_f_percent_w(df, v_group, v_analizar, quo(factor)) 
# zza <- decimales_df_pjp(as.data.frame(zz))







#----- esta cuarta f. es para arreglar los NAs y crear variables 1,0 (1 si estas en determinadas categorias)
#- pasa a NAs la lista de valores q le digas y categoriza en 1 , 0 ( 1= , 0 = resto de valores)
#- facil de extender para variar los valores q definen las categorias

my_f_arreg_nas_cat <- function(df, lista_nas, var){
  vvv <- sym(var)
  new_name_x <- paste0(sym(var), "_x")
  new_name_x1 <- paste0(sym(var), "_x1")
  Anew_name_x <- sym(new_name_x)
  Anew_name_x1 <- sym(new_name_x1)
  
  df1 <- df %>% mutate(!! Anew_name_x := ifelse(!!vvv %in% lista_nas, NA, !!vvv))  %>% mutate(!! Anew_name_x1 := ifelse(!!Anew_name_x == "1", 1, 0))
  df1  
}

# Uso:
# lista_nas <- c("8", "9") #- los valores q son Na's
# 
# df_prueba <- df %>% select(1, cataratas, piel) #- un df de prueba
# lista_var <- names(df_prueba[c(2:3)])          #- cojo los nombres de las variables a las q les quiero arreglar los Nas y categorizar
# 
# df2 <- df_prueba      #tengo q hacerlo en un bucle, una variable cada vez, podria usar map() pero ya vale
# for (ii in lista_var) {
#   
#   df2 <- my_f_arreg_Enfer(df2, lista_nas, ii)
# }


#lista_categorias_1 <- c(1,2,3)
# pp <- as.character(lista_categorias_1) %>% paste0(., collapse= ".")

# paste0(pp, collapse= "")

#----- esta QUINTA f. es para arreglar los NAs y crear variables 1,0 (1 si estas EN DETERMINADAS CATEGORIAS)
#- pasa a NAs la lista de valores q le digas y categoriza en 1 , 0 ( 1 = lista_categorias_1, 0 = resto de valores)
#- facil de extender para variar los valores q definen las categorias
#- lista_categorias_1 es la lista de categorias que vas  recodificarlas como 1

my_f_QUINTA <- function(df, var, lista_nas, lista_categorias_1){
  categorias_1 <- as.character(lista_categorias_1) %>% paste0(., collapse= ".")
  vvv <- sym(var)
  new_name_x <- paste0(sym(var), "_xx")
  new_name_x1 <- paste0(sym(var), "_", categorias_1, "_xx")
  Anew_name_x <- sym(new_name_x)
  Anew_name_x1 <- sym(new_name_x1)
  
  df1 <- df %>% mutate(!! Anew_name_x := ifelse(!!vvv %in% lista_nas, NA, !! vvv))  %>%
                mutate(!! Anew_name_x1 := ifelse(!!vvv %in% lista_categorias_1, 1, 0))  %>%
                mutate(!! Anew_name_x1 := ifelse( is.na(!! Anew_name_x) , NA, !! Anew_name_x1)) 
  df1  
}

# Uso:
# lista_nas <- c("8", "9") #- los valores q son Na's
# 
# df_prueba <- df %>% select(1, cataratas, piel) #- un df de prueba
# lista_var <- names(df_prueba[c(2:3)])          #- cojo los nombres de las variables a las q les quiero arreglar los Nas y categorizar
# 
# df2 <- df_prueba      #tengo q hacerlo en un bucle, una variable cada vez, podria usar map() pero ya vale
# for (ii in lista_var) {
#   
#   df2 <- my_f_arreg_Enfer(df2, lista_nas, ii)
# }

#- asi la usba en un script
# source("./source/my_3_funciones.R")
# valores_q_son_nas <- c("8", "9")         #- los valores q son Na's
# lista_categorias_pasar_a_1 <- c(1, 2)             #- las categorias q vas a pasar a 1 (el resto de categorias a 0)
# lista_var <- names(df[c(6, 7)])                   #- la lista de variables a quitar NAS(9,8) y categorizar 1,0
# for (ii in lista_var) {
#   df <- my_f_QUINTA(df, ii, lista_categorias_q_son_nas, lista_categorias_pasar_a_1) #- esta QUINTA f. categoriza variables (y tiene en cuenta los NAs)
# }


#- funcion especifica para quitar NAs ----------------------------------

my_f_NAs <- function(df, var, lista_nas) {
  vvv <- sym(var)
  new_name_x <- paste0(sym(var), "_xx")
  Anew_name_x <- sym(new_name_x)
  df1 <- df %>% mutate(!! Anew_name_x := ifelse(!!vvv %in% lista_nas, NA, !! vvv))
  df1  
}



#- funcion especifica para dicotomizar una variable (1,0) ----------------------------------
#- 
my_f_DICOTOMIZAR <- function(df, var, lista_categorias_1) {
  categorias_1 <- as.character(lista_categorias_1) %>% paste0(., collapse= "_")  #- yo preferia separar con "." pero Stata no lo admite, asi q uso "_" para separar los valores q entran en la categoria 1
    vvv <- sym(var)
  new_name_x1 <- paste0(sym(var), "_xx_", categorias_1)
  Anew_name_x1 <- sym(new_name_x1)
  new_name_x <- paste0(sym(var), "_xx") #- por los NAS
  Anew_name_x <- sym(new_name_x)        #- por los NAs
  
  df1 <- df %>%
    #mutate(!! Anew_name_x1 := ifelse(!!vvv %in% lista_categorias_1, 1, 0))  %>%
    #mutate(!! Anew_name_x1 := ifelse( is.na(!! Anew_name_x) , NA, !! Anew_name_x1)) 
     mutate(!! Anew_name_x1 :=  case_when( 
       #!! vvv %in% lista_categorias_1   ~ 1 ,
       !! Anew_name_x %in% lista_categorias_1   ~ 1 ,
      is.na(!! Anew_name_x)  ~ NA_real_ ,
       TRUE ~  0))   #- el resto pasa a ser cero
       #is.na(!! vvv )  ~ NA_real_ ,
       #TRUE ~  !! vvv))   #- el resto pasa a ser cero
     df1  
}



#- FUNCION para crear tablas cruzadas con el % de gente en cada grupo de la v_analizar (pero quitabdo de group la v a analizar)
#- la he arreglado para no tener q poner la v a analizar dentro del grupo de variables de grouping

my_f_percent_w_na_ok <- function(df, v_group_2, v_analizar, v_factor){
  
  df <- df %>% select(!!! syms(v_group),!!v_analizar, !! v_factor ) %>% filter(complete.cases(.)) #-quito los nas
  #df <- df %>% select(!!! syms(v_group),!!v_analizar, !! v_factor ) %>% filter(! is.na(!! v_analizar))  #-quito los nas
  
  #v_group_2 <- v_group[1:(length(v_group))-1]   #- le quito la ultima v. de grouping para el ultimo paso en que calculo los %  #- esto era antes
  #v_group <- c(v_group_2, v_analizar)
  df <- df %>% group_by(!!! syms(v_group), !! sym(v_analizar)) %>% 
    summarise(NN_casos = n(), NN_pob = sum(!!v_factor, na.rm = TRUE) , mean_w = weighted.mean(!!! syms(v_analizar), !! v_factor , na.rm = TRUE)) %>% ungroup()
  df <- df %>% 
    group_by(!!! syms(v_group_2)) %>% mutate(percent = NN_pob/sum(NN_pob)*100) %>% ungroup()
  df
}
# porcentaje de "personas" (en la poblacion) y nº de casos (en la muestra y en la poblacion) en cada categoria de v_analizar en cada uno de los grupos en v_group
# v_group <- c("estudios", "edad_x", "salud") #- las v. de GROUPING  (tb has de poner la v. sobre la q quieres obtener los calculos)    (has de poner las v. entre "")
# v_analizar <- "salud"                       #- la variable a ANALIZAR  (has de poner las v. entre "")
# xx <- v_group[1:(length(v_group))-1]
# zz <- my_f_percent_w(df, v_group, v_analizar, quo(factor)) 
# zza <- decimales_df_pjp(as.data.frame(zz))


# crear funciones para graficos y tablas para SUE del IVIE
# MYS funciones -----------------------------------------------------


#- FUNCION para hacer un ggplot
#- VERSION 6: ya puedes poner varias variables en group_by
#- https://stackoverflow.com/questions/44169505/grouping-on-multiple-programmatically-specified-vars-in-dplyr-0-6?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa
# v_group y v_analizar van con !!! y entonces has de poner "
# v_factor va con !!, asi que al llamar a la funcion has de quo()

library(rlang)

#- FUNCION para crear tablas cruzadas con el % de gente en cada grupo de la v_analizar (pero quitabdo de group la v a analizar)
#- la he arreglado para no tener q poner la v a analizar dentro del grupo de variables de grouping

my_f_graph_1 <- function(df, v_group_2, v_analizar, v_factor){
  
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


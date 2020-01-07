#- funciones para hacer graficos con ggplot2 para el informe SUE
#

#- grafico de lineas para % de una variable x grupo de edad y grupo de estudios
#- HAS de meter la v. entre comillas
get_grafico_1l <- function(df, y){
  y_var <- sym(y)
  y_edad_cruce <- sym(edad_cruce)    #- pasa un character a simbolo
  y_estudios_cruce <- sym(estudios_cruce)
  ggplot(df) + aes(x = !!y_edad_cruce, y = !!y_var, color = !!y_estudios_cruce) +
    geom_point() + geom_line(aes(group = estudios_xx_m_5))  #- OK
}

#- grafico de lineas, PERO has de meter la v sin comillas
get_grafico_1 <- function(df, y){
  y_var <- enquo(y)
  y_edad_cruce <- sym(edad_cruce)    #- pasa un character a simbolo
  y_estudios_cruce <- sym(estudios_cruce)
  ggplot(df) + aes(x = !!y_edad_cruce, y = !!y_var, color = !!y_estudios_cruce) +
    geom_point() + geom_line(aes(group = estudios_xx_m_5))  #- OK
}


#- grafico de barras para % de una variable x grupo de edad y grupo de estudios
get_grafico_2 <- function(df, y){
  y_var <- enquo(y)
  y_edad_cruce <- sym(edad_cruce)    #- pasa un character a simbolo
  y_estudios_cruce <- sym(estudios_cruce)
  ggplot(df) + aes(x = !!y_edad_cruce, y = !!y_var, fill = !!y_estudios_cruce) +geom_col(position = "dodge")
}


#- grafico de barras (coord flipped) para % de una variable x grupo de edad y grupo de estudios
get_grafico_3 <- function(df, y){
  y_var <- enquo(y)
  y_edad_cruce <- sym(edad_cruce)    #- pasa un character a simbolo
  y_estudios_cruce <- sym(estudios_cruce)
  ggplot(df) + aes(x = !!y_edad_cruce, y = !!y_var, fill = !!y_estudios_cruce) +geom_col(position = "dodge") + 
    coord_flip()#- OK
}





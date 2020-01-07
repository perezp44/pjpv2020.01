library(tidyverse)

X_factor <- rep( factor(c("Blue", "Red", "Green", "Dark")), 5)
X_numeric <- rep(c(1.23, 2.75, 4.34, 7.89, 8.44), 4)
X_integer <- as.integer(rep(c(1:5),4))
X_logical <- rep(c(TRUE, TRUE, FALSE, TRUE), 5)
X_text <- rep(c("Hola", "tete", "carambano", "adios"), 5)
fechas <- rep(c("2018/01/01", "2015/03/09"), 10)
X_POSIXct <- as.POSIXct(fechas) #- xq este me daba pbs

pjp_data_df_prueba <- tibble(X_factor, X_numeric, X_integer, X_logical, X_text, X_POSIXct)
map(pjp_data_df_prueba, class) #- Ok class gives two for X_positx


#- le voy a poner dos rows que sean NA
pjp_data_df_prueba <- pjp_data_df_prueba %>% add_row(.before = 4) %>% add_row(.before = 9)
#- pongo dos ceros
pjp_data_df_prueba$X_numeric[17] <- 0
pjp_data_df_prueba$X_numeric[19] <- 0
pjp_data_df_prueba$X_numeric[18]  <- NA
#- le voy a poner un NA


library(usethis)
# use_data(pjp_data_df_prueba, overwrite = TRUE) #- lo guarde con esta linea que usa el pkg usethis
# luego lo has de documentar ...

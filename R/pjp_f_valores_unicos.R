#' @title returns a df with the unique values in each colum of athe input df
#' @description my_df_valores_unicos() te retorna un df con los valores(unicos) que existen en cada columna de un df
#' @param df (a data frame)
#' @param nn_pjp  (cuantos valores unicos permites como maximo, default=50)
#' @export
#' @examples
#' pjp_f_valores_unicos(cars)

pjp_f_valores_unicos <- function(df, nn_pjp = 50) {
cc <- data.frame(x = 1:nn_pjp)
  for(ii in 1:length(df)){
    aa <- as.vector(unique(df[[ii]]))
    aa <- aa[!is.na(aa)]
    aa <- aa[1:nn_pjp]
    cc <- as.data.frame(cbind(cc, aa))
}
cc[,1] <- NULL
names(cc) <-  names(df)
return(cc)
}


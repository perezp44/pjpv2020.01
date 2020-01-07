#' @title redondead un df dejando los decimales q le digas
#' @description pjp_df_decimales() te retorna un df con los decimales que le digas (default = 2)
#' pjp_df_decimales function redondea los valores de un dataframe. Le metes un df y redondea sus valores
#'
#' @param df Un dataframe
#' @param nn el nº de decimales (Default = 2)
#' @return Un nuevo \code{df} con sus valores redondeados a \code{nn}
#' @examples
#' pjp_df_decimales(cars, nn = 2)
#' @export


pjp_df_decimales <- function(df, nn = 2) {
  is.num <- sapply(df, is.numeric)
  df[is.num] <- lapply(df[is.num], round, nn)
  df
}

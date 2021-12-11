#' @title returns a df with el diccionario de un df
#' @description pjp_f_dicc() returns a df con el diccionario del input df
#' @param df (a data frame)
#' @param truncate (If you want to truncate the uniques values. The default = TRUE)
#' @param nn_truncate  (if you truncate, this is the maximun character that you will see. The default = 500)
#' @return Un nuevo \code{df} con los valores unicos del df original
#' @importFrom magrittr `%>%`
#' @export
#' @examples
#' pjp_f_dicc(iris)


pjp_f_dicc <- function(df, truncate = TRUE, nn_truncate = 100) {
    df_aa <- pjpv2020.01::pjp_f_estadisticos_basicos(df)
    df_bb <- pjpv2020.01::pjp_f_unique_values(df, truncate = truncate, nn_truncate = nn_truncate)
    dicc_df <- dplyr::bind_cols(df_aa, df_bb)
    dicc_df <- dicc_df %>% dplyr::select(variable, type, nn_unique, unique_values, q_na, p_na, p_zeros, min, max, mean, sd, NN, NN_ok)

}

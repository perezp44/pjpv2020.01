#' @title returns a df with the unique values in each colum of the input df
#' @description pjp_unique_values() returns a df with the unique values that exits in each column of the input df
#' @param df (a data frame)
#' @param truncate (If you want to truncate the uniques values. The default = TRUE)
#' @param nn_truncate  (if you truncate, this is the maximun character that you will see. The default = 500)
#' @return Un nuevo \code{df} con los valores unicos del df original
#' @export
#' @examples
#' pjp_unique_values(iris)


pjp_unique_values <- function(df, truncate = FALSE, nn_truncate = 500) {
    bb <- data.frame(variables = names(df))
    cc <- df %>% purrr::map(unique) %>% purrr::map(length) %>% purrr::as_vector() %>%
                 tibble::as_tibble() %>% dplyr::rename(nn_unique = value)
    dd <- df %>% purrr::map(unique) %>% purrr::map(sort, na.last = FALSE) %>%
                 purrr::map(paste, collapse = " - ") %>% purrr::as_vector() %>%
                 tibble::as_tibble() %>% dplyr::rename(unique_values = value)
if (truncate == TRUE){
  dd <- dd %>% dplyr::mutate(unique_values = stringr::str_sub(unique_values, start = 1, end = nn_truncate) )
}
ee <- bind_cols(bb, cc,dd)
return(ee)
}



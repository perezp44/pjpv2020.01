#' @title round numbers nicely
#' @description Ya lo he dicho round numbers nicely
#' This function rounds data in a nice way. See: https://twitter.com/hspter/status/314858331598626816
#' Thanks Karl Broman!!
#' @param digits  (digitos a mostrar, default=2)
#' @export
#' @examples
#'  pjp_f_round_nice(c(-0.0002, 0.0002, 0.5, -0.5, -0.002), digits = 3)
#'  should return c("0.000", "0.000", "0.500", "-0.500", "-0.002")


pjp_f_round_nice <- function(..., digits = 2) {
  g <- sprintf(paste0("%.", digits, "f"), ...)
  z <- paste0("0.", paste(rep("0", digits), collapse=""))
  g[g==paste0("-",z)] <- z
  return(g)
}


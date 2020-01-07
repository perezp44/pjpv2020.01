#' @title mi version de not_in
#' @description te dice los valores de x q no estan en y
#'
#' @param x a vector
#' @param y a vector
#' @return Un nuevo vector con los elemntos de x q no estan en y
#' @export


pjp_not_in <- function(x,y) {
      # aa <- !('%in%'(x,y))  #- esta f. es not_in
      # xx <- x[aa]
      x[!x %in% y]
}



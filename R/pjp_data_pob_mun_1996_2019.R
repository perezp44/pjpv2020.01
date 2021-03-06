#----

#' Población municipal(Padrón INE)
#'
#' Para los años 1996, 1998-2019 y para el Total, Hombres y Mujeres
#'
#' @source \url{http://www.ine.es/dyngs/INEbase/es/operacion.htm?c=Estadistica_C&cid=1254736177011&menu=resultados&idp=1254734710990}
#'
#' @format A data frame with 11 variables
#' \itemize{
#'   \item year:
#'   \item INECodMuni:   Codigo INE del municipio  (5 digitos)
#'   \item INECodMuni.n: Nombre del municipio
#'   \item capital_prov:   1 = el municipio es capital de provincia
#'   \item capital_CCAA:   1 = el municipio es capital de CA
#'   \item INECodProv:   Codigo INE de la provincia  (2 digitos)
#'   \item INECodProv.n: Nombre de la provincia
#'   \item INECodCCAA: Código INE de la C.A. (2 digitos)
#'   \item NombreCCAA: Nombre de la C.A.
#'   \item poblacion: 3 categorias(Total, Hombresy Mujeres)
#'   \item pob_values: numero de personas
#'   }
#'
#' @examples
#' \dontrun{
#'  pob_mun_1996_2019 <- pjp_data_pob_mun_1996_2019
#' }
#'
"pjp_data_pob_mun_1996_2019"

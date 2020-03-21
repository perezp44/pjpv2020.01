#---- This file documents  datasets inside the package pjpv2020.01

#' Codigos de Eurostat para entidades españolas (y su equivalencia, si existe a código INE)
#' NUTS1 son agrupaciones de CC.AA
#' NUTS2 son CC.AA
#' NUTS3 son provincias, salvo para Baleraes y Canarias que se corresponden con islas!!
#'
#' @format A data frame with 89 rows (provincias) y 9 variables
#' \itemize{
#'   \item code13:   Codigo Eurostat
#'   \item code16:   Codigo Eurostat
#'   \item name:   Nombre de la entidad territorial
#'   \item nuts_level:   1 (agrupaciondes de CCAA), 2(CCAA), 3(provincias salvo en Baleraes y Canarias)
#'   \item change:  si ha habido o no cambios
#'   \item INECodProv:   Codigo INE de la provincia  (2 digitos)
#'   \item INECodProv.n: Nombre de la provincia
#'   \item INECodCCAA: Código INE de la C.A. (2 digitos)
#'   \item NombreCCAA: Nombre de la C.A.
#'   }
#'
#' @examples
#' \dontrun{
#'  cod_prov_INE <- pjp_data_cod_prov_INE
#' }
#'
"pjp_data_cod_prov_INE"

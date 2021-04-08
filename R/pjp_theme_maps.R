#' [ggplot2] apropiado para mapas
#'
#' @title creo un theme apropiado para mapas
#' @description theme_pjp_maps() crea un theme apropiado para mapas
#' @importFrom ggplot2 theme
#'
#' @return
#' @export
#' @examples
#' theme_pjp_maps()


theme_pjp_maps <- function(){
    ret <- ggplot2::theme_minimal() + ggplot2::theme(
        text = ggplot2::element_text(family = "Ubuntu Regular", color = "#22211d"),
        axis.line = ggplot2::element_blank(),
        axis.text.x = ggplot2::element_blank(),
        axis.text.y = ggplot2::element_blank(),
        axis.ticks = ggplot2::element_blank(),
        axis.title.x = ggplot2::element_blank(),
        axis.title.y = ggplot2::element_blank(),
        # panel.grid.minor = ggplot2::element_line(color = "#ebebe5", size = 0.2),
        panel.grid.major = ggplot2::element_line(color = NA, size = 0.2), #- "#ebebe5"
        panel.grid.minor = ggplot2::element_blank(),
        plot.background = ggplot2::element_rect(fill = "#f5f5f2", color = NA),
        panel.background = ggplot2::element_rect(fill = "#f5f5f2", color = NA),
        legend.background = ggplot2::element_rect(fill = "#f5f5f2", color = NA),
        panel.border = ggplot2::element_blank(),
        strip.text.x = ggplot2::element_blank(),
        strip.background = element_rect(colour="white", fill="white"),
        legend.position = c(.9,.2),
        plot.title = ggplot2::element_text(size = 16, face = "bold")
        )
    ret
}

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
        text = element_text(family = "Ubuntu Regular", color = "#22211d"),
        axis.line = element_blank(),
        axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks = element_blank(),
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        # panel.grid.minor = element_line(color = "#ebebe5", size = 0.2),
        panel.grid.major = element_line(color = NA, size = 0.2), #- "#ebebe5"
        panel.grid.minor = element_blank(),
        plot.background = element_rect(fill = "#f5f5f2", color = NA),
        panel.background = element_rect(fill = "#f5f5f2", color = NA),
        legend.background = element_rect(fill = "#f5f5f2", color = NA),
        panel.border = element_blank(),
        strip.text.x = element_blank(),
        strip.background = element_rect(colour="white", fill="white"),
        legend.position = c(.9,.2),
        plot.title = element_text(size = 16, face = "bold")
        )
    ret
}

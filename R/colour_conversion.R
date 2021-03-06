#' Convert R colours to RGBA hexadecimal colour values
#' @param x character for colour, for example: "white"
#' @param alpha transparency alpha
#' @return hexadecimal colour value (if is.na(x), return "transparent" for compatibility with Plotly)
#' @export
toRGB <- function(x, alpha = 1) {
  if (is.null(x)) return(x)
  if (identical(x, "NA")) x <- NA
  # as of ggplot2 version 1.1, an NA alpha is treated as though it's 1
  if (is.na(alpha)) alpha <- 1
  if (alpha != 1) {
    rgb.matrix <- col2rgb(x, TRUE)
    rgb.matrix["alpha", 1] <- alpha
    ch.vector <- "rgba(%s)"
  } else {
    rgb.matrix <- col2rgb(x)
    ch.vector <- "rgb(%s)"
  }
  rgb.text <- apply(rgb.matrix, 2, paste, collapse=",")
  rgb.css <- sprintf(ch.vector, rgb.text)
  ifelse(is.na(x), "transparent", rgb.css)
}

#' Use default ggplot colour for fill (gray20) if not declared
#' @param x character for colour
#' @param alpha transparency alpha
#' @return hexadecimal colour value
toFill <- function(x, alpha=1) {
  ifelse(!is.null(x), toRGB(x, alpha), toRGB("gray20", alpha))
}

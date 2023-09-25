styler:::style_active_file()
library(plotly)
require(ggplot2)
source("./funcs.R")

dot_choose <- as.numeric(gl(5, 2))
# equilateral triangle with side=1
dot_coords <- list(
  c(0, 0, 0), c(1, 0, 0), c(0, 1, 0), c(1, 1, 0), c(.5, .5, 1)
)

position <- c(0, 0, 0)

walk <- generate_walk(
  100000,
  dot_coords = dot_coords, position = position,
  max_dice = 10
) |>
  as.data.frame()
colnames(walk) <- c("x", "y", "z")

# dot_coords_df <-
#   data.frame(matrix(unlist(dot_coords), byrow = T, ncol = 4))
# colnames(dot_coords_df) <- c("x", "y", "z")

fig <- plot_ly(
  walk,
  x = ~x, y = ~y, z = ~z # ,
  # color = ~am, colors = c('#BF382A', '#0C4B8E')
)
fig <- fig %>% add_markers()
fig <- fig %>% layout(scene = list(
  xaxis = list(title = "x"),
  yaxis = list(title = "y"),
  zaxis = list(title = "z")
))

fig

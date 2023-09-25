styler:::style_active_file()
library(plotly)
require(ggplot2)
source("./funcs.R")

dot_choose <- as.numeric(gl(3, 2))
# equilateral triangle with side=1
dot_coords <- list(c(0, 0), c(1, 0), c(0.5, sqrt(0.75)))
# or centered with ((+/-)L/2; -sqrt(3)*L/4) and top (0; sqrt(3)*L/4)

position <- c(0, 0)

walk <- generate_walk(
  1000000,
  dot_coords = dot_coords,
  position = position
) |>
  as.data.frame()
colnames(walk) <- c("x", "y")

dot_coords_df <-
  data.frame(matrix(unlist(dot_coords), byrow = T, ncol = 2))
colnames(dot_coords_df) <- c("x", "y")

p <- ggplot(walk, aes(x = x, y = y)) +
  # geom_path(alpha = .3) + # makes a dark triangle
  geom_point(size = 0.1, stroke = NA) +
  xlim(0, 1) +
  ylim(0, 1) +
  geom_point(
    data = dot_coords_df,
    mapping = aes(x = x, y = y),
    color = "red",
    alpha = .5
  ) +
  coord_fixed(
    ratio = 1,
    xlim = c(0, 1),
    ylim = c(0, 1),
    expand = TRUE,
    clip = "on"
  )


ggsave(
  "plots/2d_walk.png",
  p,
  dpi = 1000,
  width = 15,
  height = 15,
  units = "cm"
)
# ggplotly(p)

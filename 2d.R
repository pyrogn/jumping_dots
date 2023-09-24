styler:::style_active_file()
library(plotly)
require(ggplot2)

dot_choose <- as.numeric(gl(3, 2))
# equilateral triangle with side=1
dot_coords <- list(c(0, 0), c(1, 0), c(0.5, sqrt(0.75)))
# or centered with ((+/-)L/2; -sqrt(3)*L/4) and top (0; sqrt(3)*L/4)

select_dot <- function(dice_num) {
  chosen_dot <- dot_choose[dice_num]
  dot_coords[[chosen_dot]]
}

change_position <- function(position, dot) {
  (position + dot) / 2
}

roll_dice <- function(num_rolls) {
  sample(1:6, num_rolls, replace = TRUE)
}

position <- c(0, 0)
generate_walk <- function(num_rolls) {
  visits <- list(position)
  # faster, but it will be stored in memory
  # sapply(roll_dice(30), select_dot)
  for (i in 1:num_rolls) {
    move_to_dot <- roll_dice(num_rolls = 1) |>
      select_dot()
    position <-
      change_position(position = position, dot = move_to_dot)
    visits <- append(visits, list(position))
  }

  df <- data.frame(matrix(unlist(visits), byrow = T, ncol = 2),
    step = 1:(num_rolls + 1)
  )
  colnames(df) <- c("x", "y", "step")

  return(df)
}

walk <- generate_walk(200000)

dot_coords_df <-
  data.frame(matrix(unlist(dot_coords), byrow = T, ncol = 2))
colnames(dot_coords_df) <- c("x", "y")

p <- ggplot(walk, aes(x = x, y = y)) +
  # geom_path(alpha = .3) + # makes a dark triangle
  geom_point(size = 0.3, stroke = NA) +
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

styler:::style_active_file()
library(plotly)

dot_choose <- as.numeric(gl(3, 2))
# equilateral triangle with side=1
dot_coords <- list(c(0, 0), c(1, 0), c(0.5, sqrt(3) / 2))
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

num_rolls <- 30
position <- c(0, 0)
visits <- list(position)
for (i in 1:num_rolls) {
  move_to_dot <- roll_dice(num_rolls = 1) |>
    select_dot()
  position <- change_position(position = position, dot = move_to_dot)
  visits <- append(visits, list(position))
}

df <- data.frame(matrix(unlist(visits), byrow = T, ncol = 2),
  step = 1:(num_rolls + 1)
)
colnames(df) <- c("x", "y", "step")

fig <- df |>
  plot_ly(
    x = ~x,
    y = ~y,
    frame = ~step,
    type = "scatter",
    mode = "markers",
    showlegend = F
  )
fig
# sapply(roll_dice(30), select_dot) # faster, but it will be stored in memory

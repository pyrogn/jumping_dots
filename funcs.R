library(plotly)
require(ggplot2)

select_dot <- function(dice_num, dot_coords) {
  chosen_dot <- dot_choose[dice_num]
  dot_coords[[chosen_dot]]
}

change_position <- function(position, dot) {
  (position + dot) / 2
}

roll_dice <- function(num_rolls) {
  sample(1:6, num_rolls, replace = TRUE)
}

generate_walk <- function(num_rolls, position, dot_coords) {
  visits <- matrix(nrow=num_rolls, ncol=length(dot_coords[[1]]))
  for (i in 1:num_rolls) {
    move_to_dot <- roll_dice(num_rolls = 1) |>
      select_dot(dot_coords)
    position <-
      change_position(position = position, dot = move_to_dot)
    visits[i,] <- position
  }

  return(visits)
}


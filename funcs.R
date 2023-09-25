styler:::style_active_file()
select_dot <- function(dice_num, dot_coords) {
  chosen_dot <- dot_choose[dice_num]
  dot_coords[[chosen_dot]]
}

change_position <- function(position, dot) {
  (position + dot) / 2
}

roll_dice <- function(num_rolls, max_dice = 6) {
  sample(1:max_dice, num_rolls, replace = TRUE)
}

generate_walk <- function(num_rolls, position, dot_coords, max_dice = 6) {
  visits <- matrix(nrow = num_rolls, ncol = length(dot_coords[[1]]))
  for (i in 1:num_rolls) {
    move_to_dot <- roll_dice(num_rolls = 1, max_dice = max_dice) |>
      select_dot(dot_coords)
    position <-
      change_position(position = position, dot = move_to_dot)
    visits[i, ] <- position
  }

  return(visits)
}

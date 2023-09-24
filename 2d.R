styler:::style_active_file()

dot_choose <- as.numeric(gl(3, 2))
dot_coords <- list(c(0, 0), c(1, 1), c(5, 3))

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
roll_dice(30)
(c(1, 3) + select_dot(3)) / 2

sapply(roll_dice(30), select_dot)

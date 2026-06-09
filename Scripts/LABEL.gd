extends Label

@onready var initial_position = position

const PRESS_OFFSET = 2.0

func press_animation() -> void:
   position.y = initial_position.y + PRESS_OFFSET

func release_animation() -> void:
   position.y = initial_position.y

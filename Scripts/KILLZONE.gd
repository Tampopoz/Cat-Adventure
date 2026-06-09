extends Area2D

@onready var death = $DEATH

func _on_body_entered(body: Node2D) -> void:
	if body.name == "MIKAN" || body.name == "JIRO":
		death.play()
		
		var timer = get_tree().create_timer(0.75)
		timer.timeout.connect(_reload_scene)

func _reload_scene() -> void:
	get_tree().reload_current_scene()

extends TextureButton

@onready var sound_player := AudioStreamPlayer.new()
@onready var transition_manager: TransitionManager = %TRANSITION_MNGR

func _ready() -> void:
	setup_sound()

func setup_sound() -> void:
	add_child(sound_player)
	sound_player.stream = load("res://Sound/Effect/ConfirmSL.wav")
	sound_player.volume_db = -10

func _on_pressed() -> void:
	sound_player.play()
	_transition_to_next_scene()

func _transition_to_next_scene():
	get_tree().paused = false
	
	transition_manager.start_new_transition()
	
	await transition_manager._tween.finished
	
	get_tree().change_scene_to_file("res://Scenes/FIRST_PAGE.tscn")

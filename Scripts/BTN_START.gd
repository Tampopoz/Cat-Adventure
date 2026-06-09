extends TextureButton

@onready var target_label = $".."
@onready var sound_player = AudioStreamPlayer.new()
@onready var transition_manager: TransitionManager = %TRANSITION_MNGR 

func _ready():
	button_down.connect(_on_button_down)
	button_up.connect(_on_button_up)
	
	_setup_sound()

func _setup_sound():
	add_child(sound_player)
	sound_player.stream = load("res://Sound/Effect/btn_start.wav")
	sound_player.volume_db = -10

func _on_button_down():
	target_label.press_animation()
	sound_player.play()

func _on_button_up():
	target_label.release_animation()
	_transition_to_next_scene()

func _transition_to_next_scene():
	get_tree().paused = false
	
	transition_manager.start_new_transition()
	
	await transition_manager._tween.finished
	
	get_tree().change_scene_to_file("res://Scenes/SECOND_PAGE.tscn")

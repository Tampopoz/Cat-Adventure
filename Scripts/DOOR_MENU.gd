extends Area2D

@onready var sound_player = AudioStreamPlayer.new()
@onready var transition_mngr: TransitionManager = get_tree().root.get_node("FOURD_PAGE/TRANSITION_MNGR")

func _ready():
	setup_sound()

func setup_sound():
	add_child(sound_player)
	sound_player.stream = load("res://Sound/Effect/btn_start.wav")
	sound_player.volume_db = -10

func transition_to_next_scene():
	get_tree().paused = false
	
	transition_mngr.start_new_transition()
	await get_tree().create_timer(1).timeout  
	get_tree().change_scene_to_file("res://Scenes/MAIN_MENU.tscn")

func _on_body_entered(_body: Node2D) -> void: 
	sound_player.play()
	transition_to_next_scene()

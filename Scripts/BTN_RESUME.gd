extends TextureButton

@onready var target_label = $".."
@onready var sound_player = AudioStreamPlayer.new()

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

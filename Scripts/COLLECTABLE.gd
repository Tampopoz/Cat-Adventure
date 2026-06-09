extends Area2D 

var sound_effect = preload("res://Sound/Effect/ConfirmSL.wav")
@onready var game_manager = %GAMEMANAGER

func _on_body_entered(body):
	if body.name == "MIKAN" || body.name == "JIRO":
		play_sound_and_free()
		game_manager.add_point()
		queue_free()

func play_sound_and_free():
	var temp_audio = AudioStreamPlayer2D.new()
	get_tree().get_root().add_child(temp_audio)
	temp_audio.stream = sound_effect
	temp_audio.finished.connect(temp_audio.queue_free)
	temp_audio.play()

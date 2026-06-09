extends RigidBody2D

var sound_effect = preload("res://Sound/Effect/btn_start.wav")
@onready var game_manager = %GAMEMANAGER

func play_sound_and_free():

	var temp_audio = AudioStreamPlayer2D.new()
	get_tree().get_root().add_child(temp_audio)
	temp_audio.stream = sound_effect
	
	temp_audio.finished.connect(temp_audio.queue_free)
	temp_audio.play()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "MIKAN" or body.name == "JIRO":
		
		var y_delta = position.y - body.position.y
		var x_delta = body.position.x - position.x
		
		if(y_delta > 30):
			game_manager.add_point2()
			play_sound_and_free()
			body.jump()
			queue_free()
		else:
			game_manager.decrease_health()

			var tween = create_tween()

			tween.tween_property(body, "modulate", Color.RED, 0.0)

			tween.tween_property(body, "modulate", Color.WHITE, 0.0).set_delay(0.25)
			
			if (x_delta > 0):
				body.jump_side(400)
			else:
				body.jump_side(-400)

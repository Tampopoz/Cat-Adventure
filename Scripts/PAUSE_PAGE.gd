extends Node

@onready var pause_panel: Panel = %PAUSE_PANEL

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if !get_tree().paused:
			pause_game()
		else:
			resume_game()
			
func pause_game() -> void:
	get_tree().paused = true
	pause_panel.show()
	
func resume_game() -> void:
	get_tree().paused = false
	pause_panel.hide()

func _on_btn_pressed_resume() -> void:
	resume_game()

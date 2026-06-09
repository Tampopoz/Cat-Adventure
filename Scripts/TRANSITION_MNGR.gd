extends Node
class_name TransitionManager

const FADE_LAYER: int = 100

var _fade_rect: ColorRect 
var _canvas_layer: CanvasLayer 
var _tween: Tween 

@export var transition_type: Tween.TransitionType = Tween.TRANS_CUBIC 
@export var ease_type: Tween.EaseType = Tween.EASE_IN_OUT           


func _ready() -> void:
	setup_transition()  
	perform_transition() 

func setup_transition() -> void:
	_canvas_layer = CanvasLayer.new()
	_canvas_layer.layer = FADE_LAYER
	
	_fade_rect = ColorRect.new()
	_fade_rect.color = Color(0, 0, 0, 1) 
	_fade_rect.set_anchors_preset(Control.PRESET_FULL_RECT)  
	
	_canvas_layer.add_child(_fade_rect)
	add_child(_canvas_layer)

func perform_transition() -> void:
	_tween = create_tween() 
	_tween.set_trans(transition_type) 
	_tween.set_ease(ease_type) 
	
	var transition = _tween.tween_property(
		_fade_rect,
		"color",
		Color(0, 0, 0, 0), 
		0.6  
	)
	
	transition.finished.connect(cleanup)

func start_new_transition() -> void:
	cleanup()

	setup_transition()
	_fade_rect.color = Color(0, 0, 0, 0)  
	
	_tween = create_tween()
	_tween.set_trans(transition_type)
	_tween.set_ease(ease_type)
	
	_tween.tween_property(
		_fade_rect,
		"color",
		Color(0, 0, 0, 1),  
		0.6
	)

func cleanup() -> void:
	if is_instance_valid(_fade_rect):
		_fade_rect.queue_free()
	if is_instance_valid(_canvas_layer):
		_canvas_layer.queue_free()

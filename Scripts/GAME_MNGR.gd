extends Node

@onready var points_label = %POINTLABEL
@onready var character = %MIKAN
@onready var death_timer = Timer.new()
@export var hearts: Array[Node] = []

var points = 0
var lives = 3

func _ready():
	death_timer.wait_time = 1.5
	death_timer.one_shot = true
	death_timer.timeout.connect(_on_death_timer_timeout)
	add_child(death_timer)

func decrease_health():
	lives -= 1
	for h in 3:
		if (h < lives):
			hearts[h].show()
		else:
			hearts[h].hide()
	if(lives == 0):
		play_death_animation()
		
func play_death_animation():
	character.play_death()
	death_timer.start()

func _on_death_timer_timeout():
	get_tree().reload_current_scene()
		
func add_point():
	points += 1
	update_points_display()

func add_point2():
	points += 5
	update_points_display()

func update_points_display():
	points_label.text = "POINTS : " + str(points)
	if points >= 36:
		points_label.modulate = Color(0, 1, 0, 1)

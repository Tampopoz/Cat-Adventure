extends Node

@onready var points_label = %POINTLABEL
@onready var character = %JIRO
@onready var death_timer = Timer.new()
@export var hearts: Array[Node] = []

var points = 0
var lives = 3

func _ready():
	# เช็คว่ามี hearts ครบไหม
	if hearts.size() < 3:
		print("Warning: Please assign 3 heart nodes in the Inspector!")
		return
		
	# เช็คว่าแต่ละ heart ไม่เป็น null
	for heart in hearts:
		if heart == null:
			print("Warning: One or more hearts is null! Check Inspector!")
			return
	
	# ตั้งค่า death timer
	death_timer.wait_time = 1.5
	death_timer.one_shot = true
	death_timer.timeout.connect(_on_death_timer_timeout)
	add_child(death_timer)
	
	# แสดงหัวใจตามจำนวน lives เริ่มต้น
	update_hearts_display()

# แยกฟังก์ชันสำหรับอัพเดทหัวใจออกมา
func update_hearts_display():
	if hearts.size() >= 3:
		for i in range(3):
			if hearts[i] != null:
				if i < lives:
					hearts[i].show()
				else:
					hearts[i].hide()

func decrease_health():
	lives -= 1
	update_hearts_display()  # เรียกใช้ฟังก์ชันอัพเดทหัวใจ
	
	if lives == 0:
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

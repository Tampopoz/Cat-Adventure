extends CharacterBody2D

const SPEED = 200
const JUMP_VELOCITY = -500

@onready var sprite_2d = $Sprite2D
@onready var jump_sound = $JumpSound
@onready var attack_collision = $CollisionShape2D2
@onready var gamemanager: Node = %GAMEMANAGER

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_attacking = false
var facing_right = true
var is_dead = false 

func _ready():
	attack_collision.set_deferred("disabled", true)
	update_attack_collision_position()

func update_attack_collision_position():
	var original_position = attack_collision.position
	if facing_right:
		attack_collision.position.x = abs(original_position.x)
	else:
		attack_collision.position.x = -abs(original_position.x)

func jump():
	velocity.y = JUMP_VELOCITY
	is_attacking = false
	attack_collision.set_deferred("disabled", true)
	 
func jump_side(x):
	velocity.y = JUMP_VELOCITY
	velocity.x = x
	is_attacking = false
	attack_collision.set_deferred("disabled", true)

func play_death():
	if is_dead:
		return
	is_dead = true
	velocity = Vector2.ZERO
	sprite_2d.animation = "death"
	set_physics_process(false)
	attack_collision.set_deferred("disabled", true)
	$DeathSound.play()

func handle_attack_animation():
	if is_dead:
		return
	is_attacking = true
	sprite_2d.animation = "attack"
	attack_collision.set_deferred("disabled", false)
	update_attack_collision_position()
	
	await sprite_2d.animation_finished
	
	is_attacking = false
	attack_collision.set_deferred("disabled", true)
	
func _physics_process(delta):
	if is_dead:
		return
	
	if Input.is_action_just_pressed("interact") and not is_attacking:
		handle_attack_animation()
		return
	
	if not is_attacking:
		attack_collision.set_deferred("disabled", true)
		
		if (velocity.x > 1 || velocity.x < -1):
			sprite_2d.animation = "running"
		else:
			sprite_2d.animation = "idle"
		
		if not is_on_floor():
			sprite_2d.animation = "jumping"
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump_sound.play()
		velocity.y = JUMP_VELOCITY
		is_attacking = false
		attack_collision.set_deferred("disabled", true)
	
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		if is_attacking:
			is_attacking = false
			attack_collision.set_deferred("disabled", true)
	else:
		velocity.x = move_toward(velocity.x, 0, 12)
	
	move_and_slide()
	position = position.round()
	
	if (velocity.x == 0):
		return
	var isLeft = velocity.x < 0
	sprite_2d.flip_h = isLeft
	
	if facing_right != !isLeft:
		facing_right = !isLeft
		update_attack_collision_position()

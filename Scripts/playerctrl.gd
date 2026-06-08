extends CharacterBody2D

@export var speed = 300.0
@onready var sprite =  $Sprite2D

@onready var joystick = get_tree().root.find_child("Joystick", true, false) #detect joystick
@export var special_action = false

func _physics_process(_delta):
	if special_action:
		velocity = Vector2.ZERO
		move_and_slide()
		return
	var move_dir = Vector2.ZERO
	
	# Get input from Joystick
	if joystick and joystick.input_vector != Vector2.ZERO:
		move_dir = joystick.input_vector
	
	else:
		# Fallback to WASD/Arrows (good for desktop testing)
		move_dir = Input.get_vector("Move_Left", "Move_Right", "Move_Up", "Move_Down")
	
	velocity = move_dir * speed
	move_and_slide()
	
	if Input.is_action_just_pressed("Dig"):
		dig()
		return
	if Input.is_action_just_pressed("Die"):
		die()
		return
		
# Handle Animations
	_update_animation(move_dir)

func _update_animation(direction: Vector2):
	# If there is no movement input, play Idle
	
	if direction == Vector2.ZERO:
		if sprite.animation != "Idle" and !special_action:
			sprite.play("Idle")
		return

	# Determine if the movement is more horizontal or vertical
	if abs(direction.x) > abs(direction.y):
		# Horizontal movement is dominant
		if direction.x > 0:
			sprite.play("WalkR")
		else:
			sprite.play("WalkL")
	else:
		# Vertical movement is dominant
		if direction.y > 0:
			sprite.play("WalkF") # Forward / Down in Godot 2D
		else:
			sprite.play("WalkB") # Backward / Up in Godot 2D

func dig():
	special_action = true
	sprite.play("DigF")
	await sprite.animation_finished
	print("dig animation done")
	special_action = false
	print("special action" + str(special_action))

	
func die():
	special_action = true
	sprite.play("Die")
	await sprite.animation_finished
	print("die animation done")
	special_action = false

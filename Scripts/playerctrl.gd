extends CharacterBody2D

@export var SPEED = 300.0

@onready var joystick = get_tree().root.find_child("Joystick", true, false) #detect joystick

func _physics_process(_delta):
	var move_dir = Vector2.ZERO
	
	# Get input from Joystick
	if joystick and joystick.input_vector != Vector2.ZERO:
		move_dir = joystick.input_vector
	else:
		# Fallback to WASD/Arrows (good for desktop testing)
		move_dir = Input.get_vector("Move_Left", "Move_Right", "Move_Up", "Move_Down")
	
	velocity = move_dir * SPEED
	move_and_slide()

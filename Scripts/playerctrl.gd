#This is for GAMEDEV Jam Written by Wardragon3399 & Clerami889
#It's player cntroller handle inputs of game

extends CharacterBody2D
@export_group("Player Locomotion ")
@export var walk_speed := 200
@export var run_speed := 400
@export var gravity := 1000
@export var jump_force := -550
@export var wire_speed := 1000.0
@export var wire_direction := 1;

var locomotion := PlayerLocomotion.new()
var state_machine := StateMachine.new()
var nearby_wire = null
var is_running := false
var mobile_run_toggle := false
var jump_pressed := false
var interact_pressed := false

@onready var sprite = $Sprite2D
@onready var joystick = get_tree().root.find_child(
	"Joystick",
	true,
	false
)

var input_direction := 0.0

func _ready():
	# Give player reference
	locomotion.player = self
	# Give controller reference
	state_machine.controller = self
	# assinging varibale values that set in inspector
	locomotion.walk_speed = walk_speed
	locomotion.gravity = gravity
	locomotion.jump_force = jump_force
	locomotion.wire_speed = wire_speed
	wire_direction = locomotion.wire_direction
	# Register states
	state_machine.add_state(
		"Idle",
		IdleState.new()
	)
	state_machine.add_state(
		"Move",
		MoveState.new()
	)
	state_machine.add_state(
		"Run",
		RunState.new()
	)
	# Jump and Fall
	state_machine.add_state(
		"Jump",
		JumpState.new()
	)
	state_machine.add_state(
		"Fall",
		FallState.new()
	)
	
	# Wire
	state_machine.add_state(
		"Wire",
		WireState.new()
	)
	# Initial state
	state_machine.change_state("Idle")
	
func _physics_process(delta):
	# Keyboard
	var keyboard_run = Input.is_action_pressed("Run")

	# Final run state
	is_running = (keyboard_run or mobile_run_toggle)
	
	# Mobile joystick
	if joystick and joystick.input_vector != Vector2.ZERO:
		input_direction = joystick.input_vector.x

	# Keyboard
	else:
		input_direction = Input.get_axis(
			"Move_Left",
			"Move_Right"
		)
	
	jump_pressed = jump_pressed or Input.is_action_just_pressed("Jump") # Jump button for mobile
	interact_pressed = interact_pressed or Input.is_action_just_pressed("Interact") # interation button for mobile
	
	# This is code for stamina base run system
	#if is_running and input_direction != 0:
	#	stamina -= stamina_drain * delta
	#	if stamina <= 0:
	#		stamina = 0
	#		is_running = false
	#		mobile_run_toggle = false
	#	else:
	#		stamina += stamina_recover * delta
	#		stamina = clamp(
	#			stamina,
	#			0,
	#			max_stamina
	#		)

	state_machine.physics_update(delta)
	jump_pressed = false
	interact_pressed = false

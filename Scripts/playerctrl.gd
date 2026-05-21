#This is for GAMEDEV Jam Written by Wardragon3399 & Clerami889
#It's player cntroller handle inputs of game

extends CharacterBody2D
@export_group("Player Locomotion ")
@export var walk_speed := 600.0
@export var gravity := 1000.0
@export var jump_force := -600.0
@export var wire_speed := 800.0
@export var wire_direction := 1;

var locomotion := PlayerLocomotion.new()
var state_machine := StateMachine.new()
var nearby_wire = null

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
	# Mobile joystick
	if joystick and joystick.input_vector != Vector2.ZERO:
		input_direction = joystick.input_vector.x

	# Keyboard
	else:
		input_direction = Input.get_axis(
			"Move_Left",
			"Move_Right"
		)

	state_machine.physics_update(delta)

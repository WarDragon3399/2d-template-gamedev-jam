extends CharacterBody2D
class_name PlayerController


@onready var sprite: AnimatedSprite2D = $Sprite2D
var locomotion: PlayerLocomotion
var state_machine: StateMachine
var nearby_wire: Node = null
# States
var idle_state: IdleState
var move_state: MoveState
var jump_state: JumpState
var fall_state: FallState
var wire_state: WireState

func _ready():
	locomotion = PlayerLocomotion.new()
	locomotion.controller = self

	state_machine = StateMachine.new()

	idle_state = IdleState.new()
	move_state = MoveState.new()
	jump_state = JumpState.new()
	fall_state = FallState.new()
	wire_state = WireState.new()

	# Critical: start in Idle
	state_machine.changeState(idle_state, self)

func _physics_process(delta):
	
	state_machine.update(self, delta)
	locomotion.apply_velocity(delta)

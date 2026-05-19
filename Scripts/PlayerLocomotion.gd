extends Resource
class_name PlayerLocomotion

var controller: PlayerController
@export var walk_speed = 600.0
@export var run_speed = 800.0
@export var jump_force = -600.0
@export var gravity = 1000.0
@export var wire_speed = 1000.0

var velocity: Vector2 = Vector2.ZERO
var current_wire = null
var wire_travel_direction = 1

func move(direction: float):
	var speed = run_speed if Input.is_action_pressed("Run") else walk_speed
	velocity.x = direction * speed

func jump():
	velocity.y = jump_force

func apply_gravity(delta):
	if !controller.is_on_floor():
		velocity.y += gravity * delta

func travel_wire(delta):
	if current_wire == null:
		return

	var start = current_wire.entry.global_position
	var end = current_wire.exit.global_position
	var wire_vec = (end - start).normalized()

	# Move along wire
	controller.global_position += wire_vec * wire_speed * delta

	# Project position back onto wire line (locks to rail)
	var to_player = controller.global_position - start
	var t = clamp(to_player.dot(wire_vec), 0, (end - start).length())
	controller.global_position = start + wire_vec * t

	controller.sprite.rotation = wire_vec.angle()

	# Auto exit when close enough to end
	if controller.global_position.distance_to(end) < 5.0:
		exit_wire()



func exit_wire():
	current_wire = null
	velocity = Vector2(300, jump_force)
	controller.sprite.rotation = 0   # reset rotation


func apply_velocity(_delta):
	controller.velocity = velocity
	controller.move_and_slide()

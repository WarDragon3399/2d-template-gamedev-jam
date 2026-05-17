extends CharacterBody2D

enum State {
	IDLE,
	WALK,
	RUN,
	JUMP,
	FALL,
	DIG,
	DIE, 
	WIRE
}

var current_state = State.IDLE
@export var walk_speed = 600.0
@export var run_speed = 800.0
@export var jump_force = -600.0
@export var gravity = 1000.0
var wire_direction = Vector2.ZERO
var nearby_wire = null
@export var wire_speed = 1000
@onready var sprite =  $Sprite2D
@onready var joystick = get_tree().root.find_child("Joystick", true, false) #detect joystick
var current_wire = null
var current_connector = null
var current_wire_index = 0
func _physics_process(_delta):
	# Gravity
	if current_state != State.WIRE:
		if !is_on_floor():
			velocity.y += gravity * _delta
	var direction := 0.0
	if joystick and joystick.input_vector != Vector2.ZERO:
		direction = joystick.input_vector.x
	else:
		direction = Input.get_axis("Move_Left", "Move_Right")
	
	# Run check
	var current_speed = run_speed if Input.is_action_pressed("Run") else walk_speed
	velocity.x = direction * current_speed
	
	# Jump
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = jump_force

	if Input.is_action_just_pressed("Interact") and nearby_wire:
		# Wire has connector route
		if nearby_wire.connector != NodePath():
			enter_connector(nearby_wire.get_connector())

		# Single standalone wire
		else:
			enter_wire(nearby_wire)
		print("wire")
			
	if current_state == State.WIRE:
		var target = current_wire.destination.global_position
		var wire_dir = (target - global_position).normalized()
		# Move
		global_position += (wire_dir * wire_speed * _delta)

		# Rotate visual
		sprite.rotation = wire_dir.angle()
		
		# Jump out anytime
		if Input.is_action_just_pressed("Jump"):
			exit_wire(wire_dir)
			return

		# Reached end
		if global_position.distance_to(target) < 10:
			# Connected route exists
			if current_connector != null:
				current_wire_index += 1
				# Continue to next wire
				if current_wire_index < current_connector.connected_wires.size():
					var next_wire = current_connector.get_node(current_connector.connected_wires[current_wire_index])
					enter_wire(next_wire)
				# End of route
				else:
					exit_wire(wire_dir)
				return
			
			# Standalone wire
			else:
				exit_wire(wire_dir)
			return		
	move_and_slide()
	update_state(direction)
	update_animation(direction)

func update_animation(direction):

	# Flip sprite
	if direction > 0:
		sprite.flip_h = false
	elif direction < 0:
		sprite.flip_h = true

	match current_state:
		State.IDLE:
			if sprite.animation != "Idle":
				sprite.play("Idle")
		State.WALK:
			if sprite.animation != "Walk":
				sprite.play("Walk")
		State.RUN:
			if sprite.animation != "Run":
				sprite.play("Run")
		State.JUMP:
			if sprite.animation != "Jump":
				sprite.play("Jump")
		State.FALL:
			if sprite.animation != "Fall":
				sprite.play("Fall")
		State.WIRE:
			if sprite.animation != "Wire":
				sprite.play("Wire")
				
func update_state(direction):
	if current_state == State.WIRE:
		return
	if !is_on_floor():
		if velocity.y < 0:
			current_state = State.JUMP
		else:
			current_state = State.FALL
		return

	if direction == 0:
		current_state = State.IDLE
		return

	if Input.is_action_pressed("Run"):
		current_state = State.RUN
	else:
		current_state = State.WALK	

func enter_wire(wire):
	current_wire = wire
	current_state = State.WIRE
	global_position = (	wire.entry.global_position)
	sprite.play("Wire")
	
func exit_wire(direction):
	current_wire = null
	current_state = State.JUMP
	sprite.rotation = 0
	velocity = direction * 300
	velocity.y = jump_force
	
func enter_connector(connector):
	current_connector = connector
	current_wire_index = 0
	var first_wire = current_connector.get_node(current_connector.connected_wires[0])
	enter_wire(first_wire)	

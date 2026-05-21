#This is for GAMEDEV Jam Written by Wardragon3399 & Clerami889
#It's player motions handle inputs of game

class_name PlayerLocomotion

var player

var walk_speed := 600.0
var gravity := 1000.0
var jump_force := -600.0

var current_wire = null
var wire_progress := 0.0
var wire_direction := 1
var wire_speed := 1000.0

func apply_gravity(delta):
	if !player.is_on_floor():
		player.velocity.y += gravity * delta

func move(direction):
	player.velocity.x = (direction * walk_speed)
	player.move_and_slide()
	
func jump():
	player.velocity.y = jump_force	

func is_falling():
	return player.velocity.y > 0

func is_rising():
	return player.velocity.y < 0
	
func enter_wire(wire):
	current_wire = wire
	var follow = current_wire.follow

	# Forward
	if wire.last_entered_side == "entry":
		wire_direction = 1
		follow.progress = 0

	# Reverse
	else:
		wire_direction = -1
		follow.progress = (current_wire.path.curve.get_baked_length())
			
func travel_wire(delta):
	if current_wire == null:
		return

	var follow = current_wire.follow
	follow.progress += (wire_speed * wire_direction * delta)

	var length = (current_wire.path.curve.get_baked_length())
	follow.progress = clamp(
		follow.progress,
		0,
		length
	)

	player.global_position = (follow.global_position)
	player.sprite.rotation = (follow.rotation)

	# End reached
	if (follow.progress <= 5 or follow.progress >= length - 5):
		var dir = Vector2.RIGHT.rotated(follow.rotation)
		exit_wire(dir)
		
func exit_wire(direction):
	current_wire = null
	player.sprite.rotation = 0
	player.velocity = direction * 300
	player.velocity.y = jump_force
	player.state_machine.change_state("Jump")				

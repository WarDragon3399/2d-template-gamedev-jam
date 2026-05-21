class_name FallState
extends BaseState

func enter():
	controller.sprite.play("Fall")

func physics_update(delta):
	controller.locomotion.apply_gravity(delta)
	controller.locomotion.move(controller.input_direction)

	# Flip
	if controller.input_direction > 0:
		controller.sprite.flip_h = false

	elif controller.input_direction < 0:
		controller.sprite.flip_h = true

	# Landed
	if controller.is_on_floor():
		if controller.input_direction == 0:
			state_machine.change_state("Idle")
		else:
			state_machine.change_state("Move")
	
	#wire interaction	
	if Input.is_action_just_pressed("Interact") and controller.nearby_wire:
		state_machine.change_state("Wire")		

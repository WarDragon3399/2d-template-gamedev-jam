class_name MoveState
extends BaseState

func enter():
	controller.sprite.play("Walk")

func physics_update(delta):
	controller.locomotion.apply_gravity(delta)
	controller.locomotion.move(controller.input_direction)

	# Flip
	if controller.input_direction > 0:
		controller.sprite.flip_h = false

	elif controller.input_direction < 0:
		controller.sprite.flip_h = true

	# Back to idle
	if controller.input_direction == 0:
		state_machine.change_state("Idle")
	
	# Move to Run
	if controller.is_running:
		state_machine.change_state("Run")
	
	# Jump
	if controller.jump_pressed  and controller.is_on_floor():
		controller.locomotion.jump()
		state_machine.change_state("Jump")
	
	#wire interaction	
	if controller.interact_pressed and controller.nearby_wire:
		state_machine.change_state("Wire")		

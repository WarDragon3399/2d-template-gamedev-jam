class_name RunState
extends BaseState

func enter():
	controller.sprite.play("Run")

func physics_update(delta):
	controller.locomotion.apply_gravity(delta)
	controller.locomotion.move(controller.input_direction)

	# Flip
	if controller.input_direction > 0:
		controller.sprite.flip_h = false

	elif controller.input_direction < 0:
		controller.sprite.flip_h = true

	# Stop moving
	if controller.input_direction == 0:
		state_machine.change_state("Idle")
	# Stop running
	elif !controller.is_running:
		state_machine.change_state("Move")

	# Jump
	if controller.jump_pressed  and controller.is_on_floor():
		controller.locomotion.jump()
		state_machine.change_state("Jump")
	
	#wire interaction	
	if controller.interact_pressed and controller.nearby_wire:
		state_machine.change_state("Wire")		

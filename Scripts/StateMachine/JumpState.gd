class_name JumpState
extends BaseState

func enter():
	controller.sprite.play("Jump")

func physics_update(delta):
	controller.locomotion.apply_gravity(delta)
	controller.locomotion.move(controller.input_direction)

	# Flip
	if controller.input_direction > 0:
		controller.sprite.flip_h = false

	elif controller.input_direction < 0:
		controller.sprite.flip_h = true

	# Start falling
	if controller.locomotion.is_falling():
		state_machine.change_state("Fall")
		
	#wire interaction	
	if Input.is_action_just_pressed("Interact") and controller.nearby_wire:
		state_machine.change_state("Wire")			

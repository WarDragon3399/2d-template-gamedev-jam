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
	
	# Jump
	if Input.is_action_just_pressed("Jump") and controller.is_on_floor():
		controller.locomotion.jump()
		state_machine.change_state("Jump")
	
	#wire interaction	
	if Input.is_action_just_pressed("Interact") and controller.nearby_wire:
		state_machine.change_state("Wire")		

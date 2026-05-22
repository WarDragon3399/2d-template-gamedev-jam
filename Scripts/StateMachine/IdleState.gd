class_name IdleState
extends BaseState

func enter():
	controller.sprite.play("Idle")

func physics_update(delta):
	controller.locomotion.apply_gravity(delta)
	
	# Move
	controller.locomotion.move(0)
	if controller.input_direction != 0:
		state_machine.change_state("Move")
		
	# Jump
	if controller.jump_pressed  and controller.is_on_floor():
		controller.locomotion.jump()
		state_machine.change_state("Jump")
	
	#interation 
	if controller.interact_pressed and controller.nearby_wire:
		state_machine.change_state("Wire")		
		

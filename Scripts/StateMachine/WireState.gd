class_name WireState
extends BaseState

func enter():
	controller.locomotion.enter_wire(controller.nearby_wire)
	controller.sprite.play("Wire")

func physics_update(delta):
	controller.locomotion.travel_wire(delta)

	# Jump out anytime
	if Input.is_action_just_pressed("Jump"):
		controller.locomotion.exit_wire(Vector2.UP)
		state_machine.change_state("Fall")	

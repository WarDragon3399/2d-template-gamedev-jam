extends BaseState
class_name IdleState

func enterState(controller):
	controller.sprite.play("Idle")
	print("Idle")

func updateState(controller, delta):
	var direction = Input.get_axis("Move_Left", "Move_Right")
	if direction != 0:
		controller.state_machine.changeState(controller.move_state,controller)
	elif Input.is_action_just_pressed("Jump") and controller.is_on_floor():
		controller.state_machine.changeState(controller.jump_state,controller)
	elif Input.is_action_just_pressed("Interact") and controller.nearby_wire:
		controller.state_machine.changeState(controller.wire_state,controller)
	
	

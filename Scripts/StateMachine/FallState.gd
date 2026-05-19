extends BaseState
class_name FallState

func enterState(controller):
	print("fallState")
	controller.sprite.play("Fall")

func updateState(controller, delta):
	controller.locomotion.apply_gravity(delta)

	var direction = Input.get_axis("Move_Left", "Move_Right")
	controller.locomotion.move(direction)  

	if controller.is_on_floor():
		controller.state_machine.changeState(controller.idle_state, controller)

extends BaseState
class_name MoveState

func enterState(controller):
	print("Entered MoveState")
	

func updateState(controller, delta):
	var direction = Input.get_axis("Move_Left", "Move_Right")
	controller.locomotion.move(direction)
	controller.locomotion.apply_gravity(delta)
	
	if direction > 0:
		controller.sprite.flip_h = false   # facing right
		controller.sprite.play("Walk")
	elif direction < 0:
		controller.sprite.flip_h = true    # facing left
		controller.sprite.play("Walk")

	if direction == 0:
		controller.state_machine.changeState(controller.idle_state, controller)
	elif Input.is_action_just_pressed("Jump") and controller.is_on_floor():
		controller.state_machine.changeState(controller.jump_state, controller)
	elif Input.is_action_just_pressed("Interact") and controller.nearby_wire:
		controller.state_machine.changeState(controller.wire_state,controller)

func exitState(controller):
	print("Exiting MoveState")

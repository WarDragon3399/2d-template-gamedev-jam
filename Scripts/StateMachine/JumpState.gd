extends BaseState
class_name JumpState

func enterState(controller):
	print("Entered JumpState")
	controller.locomotion.jump()
	controller.sprite.play("Jump")

func updateState(controller, delta):
	# Apply gravity while in jump
	controller.locomotion.apply_gravity(delta)

	# If velocity is positive (falling down), switch to FallState
	if controller.velocity.y > 0:
		controller.state_machine.changeState(controller.fall_state, controller)

	# Allow horizontal movement while jumping
	var direction = Input.get_axis("Move_Left", "Move_Right")
	controller.locomotion.move(direction)

func exitState(controller):
	print("Exiting JumpState")

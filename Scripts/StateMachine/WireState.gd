extends BaseState
class_name WireState

func enterState(controller):
	controller.sprite.play("Wire")
	controller.locomotion.current_wire = controller.nearby_wire

	# Snap to entry point
	if controller.nearby_wire.last_entered_side == "entry":
		controller.global_position = controller.nearby_wire.entry.global_position
	else:
		controller.global_position = controller.nearby_wire.exit.global_position


func updateState(controller, delta):
	controller.locomotion.travel_wire(delta)

	# Manual exit with Jump
	if Input.is_action_just_pressed("Jump"):
		controller.locomotion.exit_wire()
		controller.state_machine.changeState(controller.jump_state, controller)

	# Automatic exit when locomotion clears current_wire
	elif controller.locomotion.current_wire == null:
		controller.state_machine.changeState(controller.idle_state, controller)

func exitState(controller):
	print("Exiting WireState")
	controller.sprite.rotation = 0              # reset rotation
	controller.sprite.play("Idle")              # reset animation

class_name StateMachine

var controller
var current_state
var states = {}

func add_state(state_name, state):
	state.controller = controller
	state.state_machine = self
	states[state_name] = state

func change_state(state_name):
	if current_state:
		current_state.exit()
	current_state = states[state_name]
	current_state.enter()

func physics_update(delta):
	if current_state:
		current_state.physics_update(delta)

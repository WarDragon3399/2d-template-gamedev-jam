extends Node

class_name StateMachine

var current_state : BaseState

func changeState(new_state: BaseState,owner):
	if current_state:
		current_state.exitState(owner)
	current_state = new_state
	current_state.enterState(owner)


func update(owner , _delta):
	if current_state:
		current_state.updateState(owner,_delta)

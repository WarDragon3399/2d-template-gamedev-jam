extends Control

@export var max_radius := 60.0
@onready var base = $Base
@onready var knob = $Base/Knob

var touch_index := -1
var input_vector := Vector2.ZERO
var center := Vector2.ZERO

func _ready():
	await get_tree().process_frame
	center = base.size / 2
	knob.pivot_offset = knob.size / 2
	_reset_knob()
	base.visible = false

func _input(event):

	# TOUCH PRESS
	if event is InputEventScreenTouch:
		if event.position.x > get_viewport_rect().size.x * 0.5:
				return
		if event.pressed and touch_index == -1:
			touch_index = event.index
			# Move joystick to touch position
			base.global_position = event.position - center
			base.visible = true
			_move_knob(event.position)

		elif not event.pressed and event.index == touch_index:
			touch_index = -1
			input_vector = Vector2.ZERO
			base.visible = false
			_reset_knob()

	# TOUCH DRAG
	elif event is InputEventScreenDrag:
		if event.index == touch_index:
			_move_knob(event.position)


func _move_knob(screen_pos):
	var local_pos = screen_pos - base.global_position
	var offset = local_pos - center
	if offset.length() > max_radius:
		offset = offset.normalized() * max_radius
	knob.position = center + offset - (knob.size / 2)
	input_vector = offset / max_radius

func _reset_knob():
	knob.position = center - (knob.size / 2)

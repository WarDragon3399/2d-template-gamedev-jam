extends Node2D

@onready var path = $Path2D
@onready var entry = $EntryArea
@onready var exit = $ExitArea
@onready var follow = $Path2D/PathFollow2D
@onready var entry_icon = $EntryArea/EntryIcon
@onready var exit_icon = $ExitArea/ExitIcon

var last_entered_side = "entry"

func _on_entry_area_body_entered(body):
	if body.name == "Player":
		print("entry detected")
		entry_icon.visible = true
		last_entered_side = "entry"
		body.nearby_wire = self

func _on_entry_area_body_exited(body):
	if body.name == "Player":
		entry_icon.visible = false
		if body.nearby_wire == self:
			body.nearby_wire = null

func _on_exit_area_body_entered(body):
	if body.name == "Player":
		print("entry detected")
		exit_icon.visible = true
		last_entered_side = "exit"
		body.nearby_wire = self

func _on_exit_area_body_exited(body):
	if body.name == "Player":
		exit_icon.visible = false
		if body.nearby_wire == self:
			body.nearby_wire = null

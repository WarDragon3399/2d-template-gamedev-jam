extends Node2D

@onready var entry = $EntryArea
@onready var exit = $ExitArea
@onready var entry_icon = $EntryIcon
@onready var exit_icon = $ExitIcon

var last_entered_side = "entry"
@export var connector : NodePath

func _on_entry_entered(body):
	if body.name == "Player":
		entry_icon.visible = true
		body.nearby_wire = self
		last_entered_side = "entry"

func _on_entry_exited(body):
	if body.name == "Player":
		entry_icon.visible = false
		body.nearby_wire = null

func _on_exit_entered(body):
	if body.name == "Player":
		exit_icon.visible = true
		body.nearby_wire = self
		last_entered_side = "exit"

func _on_exit_exited(body):
	if body.name == "Player":
		exit_icon.visible = false
		body.nearby_wire = null

func get_connector():
	return get_node(connector)

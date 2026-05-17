extends Node2D

@onready var entry = $Area2D
@onready var destination = $Marker2D
@onready var icon = $InteractIcon
@export var connector : NodePath

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		icon.visible = true
		body.nearby_wire = self

func _on_area_2d_body_exited(body):
	if body.name == "Player":
		icon.visible = false
		body.nearby_wire = null		

func get_connector():
	return get_node(connector)

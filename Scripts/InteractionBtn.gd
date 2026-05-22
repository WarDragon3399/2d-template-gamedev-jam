extends Button

@onready var player = get_tree().root.find_child(
	"Player",
	true,
	false
)

func _pressed():
	player.interact_pressed = true

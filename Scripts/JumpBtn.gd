extends Button

@onready var player = get_tree().root.find_child(
	"Player",
	true,
	false
)

func _pressed():
	player.jump_pressed = true

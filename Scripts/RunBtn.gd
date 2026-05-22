extends Button

@onready var player = get_tree().root.find_child(
	"Player",
	true,
	false
)

func _pressed():
	player.mobile_run_toggle = (!player.mobile_run_toggle)

func _process(_delta):
	modulate.a = (
		1.0
		if player.mobile_run_toggle
		else 0.5
	)

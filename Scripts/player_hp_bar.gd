extends ProgressBar

var y_relative = 0
var player: Node2D

func _ready() -> void:
	player = get_tree().root.get_node("Game/Player")
	max_value = player.health
	value = player.health
	
func _process(delta: float) -> void:
	value = player.health
	global_position = player.global_position + Vector2(0, y_relative)

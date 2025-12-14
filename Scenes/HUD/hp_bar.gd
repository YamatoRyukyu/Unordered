extends Marker2D

@export var target:Node2D
@export var relative:Vector2
var bar:ProgressBar

func _ready() -> void:
	bar = %HPBar
	bar.max_value = target.health
	
func _process(delta: float) -> void:
	bar.value = target.health
	global_position = target.global_position + relative

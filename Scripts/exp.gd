extends Area2D

var target:Node2D
var move_speed = 500

func _ready() -> void:
	target = self

func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(target.global_position)
	global_position += direction * move_speed * delta

func _on_body_entered(body: Node2D) -> void:
	body.get_exp()
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	target = area.get_parent()

extends "res://Scripts/action.gd"

var marker
var canon_ball

func _ready() -> void:
	super._ready()
	marker =$TargetPoint
	canon_ball =$CollisionShape2D
	
	set_attack_distance()
	
func set_attack_distance():
	marker.position.x = base_attack_distance
	
func _physics_process(delta):
	var direction = (marker.global_position - canon_ball.global_position).normalized()
	canon_ball.global_position += direction * attack_speed * get_process_delta_time()

	if canon_ball.position.x >= base_attack_distance:
		queue_free()

extends Area2D

@export var base_attack_distance:float
@export var base_attack_damage:float
@export var attack_speed: float

var marker
var canon_ball
var player

func _ready() -> void:
	marker =$TargetPoint
	canon_ball =$CollisionShape2D
	player = get_tree().root.get_node("Game/Player")
	
	set_attack_distance()
	
func set_attack_distance():
	marker.position.x = base_attack_distance
	
func _physics_process(delta):
	var direction = (marker.global_position - canon_ball.global_position).normalized()
	canon_ball.global_position += direction * attack_speed * get_process_delta_time()

	if canon_ball.position.x >= base_attack_distance:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		var action_area = player.get_node("action_area")
		if action_area.has_method("calc_damage"):
			action_area.calc_damage(body, base_attack_damage)

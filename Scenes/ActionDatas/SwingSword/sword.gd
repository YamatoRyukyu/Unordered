extends "res://Scripts/action.gd"

var sword: Node2D

func _ready() -> void:
	super._ready()
	sword = $Marker2D
	
	#When base_attack_rotation =90, set start rotation as -45, and swing to 45
	sword.rotation_degrees = base_attack_rotation/2 * -1
	
func _physics_process(delta: float) -> void:
	sword.rotation_degrees += attack_speed * get_process_delta_time()
	
	if sword.rotation_degrees >= base_attack_rotation/2:
		queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		var action_area = player.get_node("action_area")
		if action_area.has_method("calc_damage"):
			action_area.calc_damage(body, base_attack_damage)

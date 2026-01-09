extends Area2D

signal touched_enemy

@export var base_attack_damage: float =10.0
@export var base_buff_amount: float =1.0
@export var base_attack_distance: float = 3000.0
@export_range(0, 360, 1.0, "hide_slider") var base_attack_rotation: int =45
@export var attack_speed: float =2500.0
@export var knockback_force :float =0.0

var player: Node2D

func _ready() -> void:
	player = get_tree().root.get_node("Game/Player")
	connect("body_entered", _on_body_entered)
	connect("touched_enemy", _on_touched_enemy)

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		var action_area = player.get_node("action_area")
		if action_area.has_method("calc_damage"):
			action_area.calc_damage(body, base_attack_damage)
			touched_enemy.emit()
			
	if body.has_method("apply_knockback"):
		var direction =(body.global_position - global_position).normalized()
		body.apply_knockback(direction *knockback_force)

func _on_touched_enemy():
	pass


func setup_collision(target_mask: int):
	collision_mask =target_mask

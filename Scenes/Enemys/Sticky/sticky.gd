extends EnemyBase

@onready var attack_zone: Area2D =$AttackZone

func _calc_movement(delta: float) -> Vector2:
	return global_position.direction_to(player.global_position)

func _process_attack(delta: float) -> void:
	if player in attack_zone.get_overlapping_bodies():
		player.take_damage(base_power *delta)

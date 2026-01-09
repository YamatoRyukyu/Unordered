extends EnemyBase

@onready var attack_zone: Area2D =$ExplosionArea
@onready var particle: GPUParticles2D =$ExplosionParticle

var has_explosion: bool =false

func _calc_movement(delta: float) -> Vector2:
	if has_explosion:
		return Vector2.ZERO
	return global_position.direction_to(player.global_position)
	
func _process_attack(delta: float) -> void:
	if has_explosion:
		if player in attack_zone.get_overlapping_bodies():
			player.take_damage(base_power)
		return
		
	if player in attack_zone.get_overlapping_bodies():
		particle.emitting =true
		$Sprite2D.visible =false
		has_explosion =true
		await  particle.finished
		queue_free()

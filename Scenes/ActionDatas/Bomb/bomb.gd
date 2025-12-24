extends "res://Scripts/action.gd"

var target: CollisionShape2D
var particle: GPUParticles2D
var process_material: ParticleProcessMaterial
var count:float =0.0
var flag:bool

var MATERIAL_SCALE =100

func _ready() -> void:
	super._ready()
	target = $CollisionShape2D
	particle = $CollisionShape2D/GPUParticles2D
	process_material = particle.process_material
	flag = false
	_set_position()
	
func _set_position():
	var position_change:Vector2 = Vector2(
		randf_range(-base_attack_distance, base_attack_distance), 
		randf_range(-base_attack_distance, base_attack_distance)
		)
	target.global_position = global_position + position_change
	
	
func _process(delta: float) -> void:
	count += get_process_delta_time()
	
	process_material.scale_max = self.scale.x * MATERIAL_SCALE
	
	if count >= attack_speed and not particle.emitting and not flag:
		particle.emitting =true
		flag =true
		target.disabled = false
	
	if flag and not particle.emitting:
		queue_free()

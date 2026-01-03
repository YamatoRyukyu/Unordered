extends "res://Scripts/action.gd"

var detect_collision: CollisionShape2D
var detect_area: Area2D
var bullet: CollisionShape2D

var traveled_distance:float =0.0

func _ready() -> void:
	super._ready()
	detect_collision =%DetectCollision
	detect_area =%DetectArea
	bullet =$CollisionShape2D
	detect_collision.shape.radius =base_attack_distance
	
func _physics_process(delta: float) -> void:
	var enemies_in_range:Array[Node2D] = detect_area.get_overlapping_bodies()
	if enemies_in_range.size() >0:
		var target_enemy =enemies_in_range.front()
		look_at(target_enemy.global_position)
	
	var bullet_direction =Vector2.RIGHT
	bullet.position +=bullet_direction * attack_speed * delta
	traveled_distance += attack_speed *delta
	
	if traveled_distance >= base_attack_distance:
		queue_free()

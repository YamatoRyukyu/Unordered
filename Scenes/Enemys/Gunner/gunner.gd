extends EnemyBase

@export var shoot_range: float =500
@export var shoot_scene: ActionData
@onready var range_pointer: ColorRect =$%RangePointer

@export var attack_rate: float =0.5
var attack_count: float =0
var POINTER_WIDTH: float =100.0

var detect_area: Area2D

func _on_ready_setup():
	range_pointer.size.x =shoot_range
	$DetectArea/CollisionShape2D.shape.size.x =shoot_range
	detect_area =$DetectArea

func _calc_movement(delta: float) -> Vector2:
	if player in detect_area.get_overlapping_bodies():
		return Vector2.ZERO
	else :
		return global_position.direction_to(player.global_position)

func _process_attack(delta: float) -> void:
	if player in detect_area.get_overlapping_bodies():
		# Shoot by attack count 
		if attack_count >= attack_rate:
			attack_count =0
			action_area.generate_action(shoot_scene, power)
		
		# Change width and position for spread from center
		range_pointer.size.y =attack_count *POINTER_WIDTH
		range_pointer.position.y =-range_pointer.size.y /2
		attack_count += delta
		
	else :
		range_pointer.size.y =0

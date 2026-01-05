extends "res://Scripts/action.gd"

var broom_body :AnimatableBody2D
var traveled_distance:float =0.0

func _ready() -> void:
	super._ready()
	broom_body =%BroomBody
	
func _physics_process(delta: float) -> void:
	var movement:Vector2 =Vector2(attack_speed, 0) *delta
	var rotated_movement:Vector2 =movement.rotated(global_rotation)
	broom_body.move_and_collide(rotated_movement)
	
	traveled_distance += attack_speed *delta
	if traveled_distance >= base_attack_distance:
		queue_free()

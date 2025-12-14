extends Node2D

var ExpOrb:PackedScene

func _ready() -> void:
	ExpOrb = preload("res://Scenes/experience_orb.tscn")
	
func spawn(position:Vector2):
	var exp_scene = ExpOrb.instantiate()
	exp_scene.global_position = position
	get_tree().root.add_child(exp_scene)

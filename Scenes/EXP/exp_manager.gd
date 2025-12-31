extends Node2D

var ExpOrb:PackedScene

func _ready() -> void:
	ExpOrb = preload("res://Scenes/EXP/experience_orb.tscn")
	
func spawn(position:Vector2, num:int):
	for i in range(num):
		var exp_scene = ExpOrb.instantiate()
		exp_scene.global_position = position
	
		#wait till flush queries
		await get_tree().create_timer(0).timeout
		get_tree().root.add_child(exp_scene)

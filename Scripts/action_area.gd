extends Node2D

func generate_action(action_data: ActionData):
	var action_scene: PackedScene = action_data.action_scene

	var action_instance = action_scene.instantiate()	
	action_instance.global_position = global_position	
	action_instance.global_rotation = global_rotation
	get_tree().root.add_child(action_instance)

func calc_damage(target: Node2D, damage: float):
	target.take_damage(damage)

extends Node2D

var buff_multiplier ={
	"range":1.0,
	"size":1.0,
	"action_quantity":1.0
}

func generate_action(action_data: ActionData):
	var action_scene: PackedScene = action_data.action_scene

	for i in range(buff_multiplier["action_quantity"]):
		var action_instance = action_scene.instantiate()
		action_instance.base_attack_distance *= buff_multiplier["range"]
	
		var size = buff_multiplier["size"]
		action_instance.scale *= Vector2(size,size)
	
		action_instance.global_position = global_position
		
		var angle = 360.0 / buff_multiplier["action_quantity"] * i
		action_instance.global_rotation_degrees = angle + global_rotation_degrees
		
		get_tree().root.add_child(action_instance)

func calc_damage(target: Node2D, damage: float):
	target.take_damage(damage)

func generate_upgrade(type:String, value:float):
	buff_multiplier[type] *= value

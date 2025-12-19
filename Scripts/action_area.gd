extends Node2D

var buff_multiplier ={
	"range":1.0,
	"size":1.0,
}

func generate_action(action_data: ActionData):
	var action_scene: PackedScene = action_data.action_scene

	var action_instance = action_scene.instantiate()
	var marker = action_instance.get_node("TargetPoint")
	marker.position.x *= buff_multiplier["range"]
	
	var size = buff_multiplier["size"]
	action_instance.scale *= Vector2(size,size)
	
	action_instance.global_position = global_position
	action_instance.global_rotation = global_rotation
	get_tree().root.add_child(action_instance)

func calc_damage(target: Node2D, damage: float):
	target.take_damage(damage)

func generate_upgrade(type:String, value:float):
	buff_multiplier[type] *= value

func action_upgrade(type:String, value:float):
	buff_multiplier[type] *= value

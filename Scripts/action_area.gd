extends Node2D

@export_flags_2d_physics var attack_target_mask: int

var buff_multiplier ={
	"range":1.0,
	"size":1.0,
	"action_quantity":1.0
}

var next_action_multiplier: float =1.0

func generate_action(action_data: ActionData, power: float):
	var action_scene: PackedScene = action_data.action_scene

	for i in range(buff_multiplier["action_quantity"]):
		var action_instance = action_scene.instantiate()
		
		if action_instance.has_method("setup_collision"):
			action_instance.setup_collision(attack_target_mask)

		
		var player =get_parent()
		if action_instance.has_method("_on_player_change_action"):
			player.change_action.connect(action_instance._on_player_change_action)
		
		action_instance.base_attack_distance *= buff_multiplier["range"]
	
		var size = buff_multiplier["size"]
		action_instance.scale *= Vector2(size,size)
	
		action_instance.global_position = global_position
		
		var angle = 360.0 / buff_multiplier["action_quantity"] * i
		action_instance.global_rotation_degrees = angle + global_rotation_degrees
		
		action_instance.base_attack_damage *= (power *next_action_multiplier)
		if action_instance.base_buff_amount != 1.0:
			action_instance.base_buff_amount *= next_action_multiplier
		
		get_tree().root.add_child(action_instance)
		
		next_action_multiplier =action_instance.base_buff_amount

func calc_damage(target: Node2D, damage: float):
	target.take_damage(damage)

func generate_upgrade(type:String, value:float):
	buff_multiplier[type] *= value

func reset_action_multiplier():
	next_action_multiplier =1.0

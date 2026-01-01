extends Control

var deck: HBoxContainer
var action_resources: Array[ActionData]
var action_resources_path: Array[String]
var option_scene: PackedScene

func _ready() -> void:
	deck =$HBoxContainer
	option_scene =preload("res://Scenes/PrepareSlot/option.tscn")
	
	var save_data =load(GameManager.save_res_path)	
	for action in save_data.action_resources:
		if action["is_unlocked"]:
			var resource = load(action["path"])
			action_resources.append(resource)
	instantiate_options()	
		
func instantiate_options() -> void:
	for resource in action_resources:
		if resource.is_unlocked:
			var option_instance =option_scene.instantiate()
			option_instance.action =resource
			option_instance.texture =resource.icon
			deck.add_child(option_instance)

func _on_area_2d_area_entered(area: Area2D) -> void:
	var option:Control =area.get_parent().get_parent().get_parent()
	option.check_parent =$HBoxContainer

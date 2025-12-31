extends Control

var deck: HBoxContainer
var action_resources: Array[ActionData]
var action_resources_path: Array[String]
var option_scene: PackedScene

func _ready() -> void:
	deck =$HBoxContainer
	option_scene =preload("res://Scenes/PrepareSlot/option.tscn")
	
	action_resources_path=[
	"res://Scenes/ActionDatas/Bomb/Bomb.tres",
	"res://Scenes/ActionDatas/Canon/canon.tres",
	"res://Scenes/ActionDatas/SwingSword/sword.tres"
	]
	
	for path in action_resources_path:
		action_resources.append(load((path)))
		
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

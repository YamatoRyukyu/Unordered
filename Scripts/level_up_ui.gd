extends Control

@export var upgrade_options: Array[PackedScene]

@onready var option_container = %OptionContainer

@export var option_num:int

signal upgrade_chosen(upgrade_type: String, upgrade_value: float)

	
func chose_options():
	upgrade_options.shuffle()
	var chosen_options: Array[PackedScene]
	chosen_options = upgrade_options.slice(0, option_num)
	for option_scene in chosen_options:
		var option_instance = option_scene.instantiate()
		option_instance.connect("upgrade_selected", _on_upgrade_selected)
		option_container.add_child(option_instance)	

func free_options():
	for child in option_container.get_children():
		child.queue_free()

func _on_player_call_levelup_ui() -> void:
	chose_options()
	visible =true

func _on_upgrade_selected(upgrade_type: String, upgrade_value: float):
	upgrade_chosen.emit(upgrade_type, upgrade_value)
	free_options()
	get_tree().paused =false
	visible =false

extends Control

var player:Node2D
@onready var slot: PackedScene = preload("res://Scenes/slot.tscn")

var slot_num:int
var last_action_index:int

func _ready() -> void:
	last_action_index =-1
	player = get_tree().root.get_node("Game/Player")
	slot_num = player.action_resources.size()
	set_slot()
	
func _process(delta: float) -> void:
	var current_index = player.action_index
	
	if current_index != last_action_index:
		var current_slot: CenterContainer =$HBoxContainer.get_child(current_index)
		current_slot.get_node("Control/Shade").visible = false
		print(current_slot.get_node("Control/Shade").visible)
		
		var last_slot: CenterContainer =$HBoxContainer.get_child(last_action_index)
		last_slot.get_node("Control/Shade").visible =true
		last_action_index = current_index
	
func set_slot():
	for i in range(slot_num):
		var slot_instance = slot.instantiate()
		var action_data: ActionData = player.action_resources[i]
		var texture: Texture2D = action_data.icon
		
		slot_instance.get_node("Control/Icon").texture = texture
		$HBoxContainer.add_child(slot_instance)

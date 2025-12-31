extends Control

var player:Node2D
@onready var slot: PackedScene = preload("res://Scenes/ActionSlot/slot.tscn")

var slot_num:int
var last_action_index:int

func _ready() -> void:
	last_action_index =0
	player = get_tree().root.get_node("Game/Player")
	slot_num = player.action_resources.size()
	set_slot()
	
		
func set_slot():
	for i in range(slot_num):
		var slot_instance = slot.instantiate()
		var action_data: ActionData = player.action_resources[i]
		if action_data != null:
			var texture: Texture2D = action_data.icon		
			slot_instance.get_node("Control/Icon").texture = texture
		$HBoxContainer.add_child(slot_instance)

func _on_player_change_action(current_index:int) -> void:
	for i in range(slot_num):
		var current_slot: CenterContainer =$HBoxContainer.get_child(i)

		if i == current_index:
			current_slot.get_node("Control/Shade").visible = false
		else :
			current_slot.get_node("Control/Shade").visible = true

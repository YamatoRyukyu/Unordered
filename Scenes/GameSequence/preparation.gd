extends CanvasLayer

var slot_num:int
var slot_scene:PackedScene
var ActionSlots:HBoxContainer

func _ready() -> void:
	slot_num =GameManager.player_action_len
	
	slot_scene = preload("res://Scenes/PrepareSlot/slot.tscn")
	ActionSlots =$ActionSlots
	for i in range(slot_num):
		var slot_instance =slot_scene.instantiate()
		ActionSlots.add_child(slot_instance)

func _on_start_pressed() -> void:
	var temp_deck:Array[ActionData]
	
	for slot in ActionSlots.get_children():
		if slot.has_method("get_option_action"):
			var action_data =slot.get_option_action()
			temp_deck.append(action_data)
		else :
			temp_deck.append(null)
			
	GameManager.player_actions =temp_deck
	GameManager.load_game_scene()

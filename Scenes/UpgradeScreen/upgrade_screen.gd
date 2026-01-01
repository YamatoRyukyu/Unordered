extends CanvasLayer

var upgrade_slots: HBoxContainer
var save_data:SaveData

func _ready() -> void:
	var save_res_path =GameManager.save_res_path
	save_data = load(save_res_path)
	
	upgrade_slots =$HBoxContainer
	init_upgrade_options()
	_connect_child()
	

func init_upgrade_options():	
	var upgrades_dect: Dictionary =save_data.upgrades
	for slot in upgrade_slots.get_children():
		var option:String = slot.option_text.to_lower()
		if upgrades_dect[option] != null:
			slot.value = upgrades_dect[option]

func _connect_child():
	for child in upgrade_slots.get_children():
		child.value_updated_signal.connect(_update_child)	
		child.value_update()

func _update_child(opt_low:String, value:int):
	save_data.upgrades[opt_low] =value
	
	

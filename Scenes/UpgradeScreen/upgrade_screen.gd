extends CanvasLayer

var upgrade_slots: HBoxContainer

var point_label: Label
var point: int

var save_data:SaveData

func _ready() -> void:
	save_data = GameManager.save_res
	
	point =save_data.upgrade_resource
	
	upgrade_slots =$HBoxContainer
	point_label =%PointLabel
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
	_updata_point_label()
	
func _updata_point_label():
	point =save_data.upgrade_resource
	point_label.text =str(point)

func _on_back_button_pressed() -> void:
	GameManager.load_title_scene()

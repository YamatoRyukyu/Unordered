@tool
extends Control

var OptionLabel: Label
var ValueLabel: Label

@export var max_level =5
@export var option_text: String
@export var value: int =1

signal value_updated_signal(opt_low:String, val:int)

func _ready() -> void:
	OptionLabel =$LabelBG/OptionLabel
	ValueLabel =$NumBG/NumLabel
	
	OptionLabel.text = option_text
	value_update()
	
func value_update():
	ValueLabel.text ="Lv " +str(value)
	value_updated_signal.emit(option_text.to_lower(), value)


func _on_right_button_button_down() -> void:
	if value < max_level and GameManager.save_res.upgrade_resource >=1:
		value +=1
		GameManager.save_res.upgrade_resource -=1
		value_update()



func _on_left_button_button_down() -> void:
	if value > 1:
		value -=1
		GameManager.save_res.upgrade_resource +=1
		value_update()

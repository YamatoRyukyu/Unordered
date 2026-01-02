extends CanvasLayer

var last_level:int
var time:int

var time_label: Label
var level_label: Label
var point_label: Label

func _ready() -> void:
	last_level = GameManager.last_level
	time =GameManager.survive_time
	
	time_label =%TimeValueLabel
	level_label =%LevelValueLabel
	point_label =%PointValueLabel
	
	_value_set()

func _value_set():
	level_label.text =str(last_level)
	var minute = time/60
	var second = time%60
	time_label.text = str(minute).pad_zeros(2) + ":" + str(second).pad_zeros(2)
	
	var point: int =last_level/10
	point_label.text =str(point)
	GameManager.save_res.upgrade_resource +=point


func _on_exit_button_button_down() -> void:
	GameManager.load_title_scene()


func _on_restart_button_button_down() -> void:
	GameManager.load_prepare_scene()

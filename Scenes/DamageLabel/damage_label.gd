extends Label

var timer :Timer
@export var disp_time: float =0.5

func _ready() -> void:
	timer =$DamageDisplayTimer
	timer.wait_time =disp_time
	timer.start()

func set_label_text(label_string:String):
	text =label_string

func _on_damage_display_timer_timeout() -> void:
	queue_free()

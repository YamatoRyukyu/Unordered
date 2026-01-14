extends CanvasLayer

var master_slider: Slider
var bgm_slider: Slider
var se_slider: Slider

func _ready() -> void:
	master_slider =%Master
	bgm_slider =%BGM
	se_slider =%SE
	
	_slider_value_init(master_slider, AudioManager.get_master_volume_linear())
	_slider_value_init(bgm_slider, AudioManager.get_bgm_volume_linear())
	_slider_value_init(se_slider, AudioManager.get_sfx_volume_linear())

func _slider_value_init(slider: Slider, value: float):
	slider.value =value

func _on_master_value_changed(value: float) -> void:
	AudioManager.set_master_volume(value)

func _on_bgm_value_changed(value: float) -> void:
	AudioManager.set_bgm_volume(value)

func _on_se_value_changed(value: float) -> void:
	AudioManager.set_sfx_volume(value)


func _on_exit_button_down() -> void:
	self.queue_free()

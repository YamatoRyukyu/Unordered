extends CanvasLayer


func _on_back_button_button_down() -> void:
	self.queue_free()

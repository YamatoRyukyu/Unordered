extends CanvasLayer




func _on_continue_button_button_down() -> void:
	get_tree().paused =false
	queue_free()



func _on_restart_button_button_down() -> void:
	get_tree().paused =false
	GameManager.load_game_scene()
	


func _on_exit_button_button_down() -> void:
	get_tree().paused =false
	GameManager.load_title_scene()


func _on_setting_button_down() -> void:
	GameManager.load_setting_scene()

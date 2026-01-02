extends CanvasLayer

var GameScene = "res://Scenes/GameSequence/survive_game.tscn"

func _on_start_button_pressed() -> void:
	GameManager.load_prepare_scene()

func _on_end_button_pressed() -> void:
	get_tree().quit()


func _on_upgrade_button_pressed() -> void:
	GameManager.load_upgrade_scene()

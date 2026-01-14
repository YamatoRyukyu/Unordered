extends CanvasLayer

var CreditScene: PackedScene = load("res://Scenes/Credit/credit.tscn")

func _on_start_button_pressed() -> void:
	GameManager.load_prepare_scene()

func _on_end_button_pressed() -> void:
	get_tree().quit()


func _on_upgrade_button_pressed() -> void:
	GameManager.load_upgrade_scene()


func _on_credit_pressed() -> void:
	var credit_scene_instance =CreditScene.instantiate()
	add_child(credit_scene_instance)

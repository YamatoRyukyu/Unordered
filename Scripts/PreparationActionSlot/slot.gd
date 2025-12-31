extends AspectRatioContainer

var control:CenterContainer
var BG:ColorRect
@export var texture:Texture2D
var sprite:Sprite2D
var action_slots: HBoxContainer

func _ready() -> void:
	control =$CenterContainer
	BG =$CenterContainer/BackGround
	sprite =$CenterContainer/Control/Sprite2D
	sprite.texture = texture
	adjust_sprite_to_control()

func adjust_sprite_to_control():
	if sprite.texture:
		var control_size = control.size
		var texture_size = sprite.texture.get_size()
		var scale_factor = Vector2(
			control_size.y / texture_size.y,
			control_size.y / texture_size.y
		)
		sprite.scale = scale_factor	

func _on_area_2d_area_entered(area: Area2D) -> void:
	var option:Control =area.get_parent().get_parent().get_parent()
	option.check_parent =$CenterContainer
	
	for child in control.get_children():
		if child is Option:
			print(child.action)

func get_option_action():
	for child in control.get_children():
		if child is Option:
			return child.action
		
	return null

extends CenterContainer

@export var icon_texture: Texture2D

@onready var sprite = $Control/Icon
@onready var control = $"."

func _ready() -> void:
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
		

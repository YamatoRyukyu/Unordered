extends Button

signal upgrade_selected(upgrade_type:String, upgrade_value:float)

@export var icon_texture: Texture2D
@export var description_text: String
@export var upgrade_effect: String

@export var upgrade_type:String
@export var upgrade_value:float

@onready var sprite = %Sprite2D
@onready var label = %Label
@onready var control = %CenterContainer

func _ready() -> void:
	sprite.texture = icon_texture
	label.text = description_text
	
	await get_tree().process_frame
	call_deferred("adjust_sprite_to_control")

func _on_pressed() -> void:
	upgrade_selected.emit(upgrade_type, upgrade_value)

func adjust_sprite_to_control():
	if sprite.texture:
		var control_size = control.size
		var texture_size = sprite.texture.get_size()
		var scale_factor = Vector2(
			control_size.y / texture_size.y,
			control_size.y / texture_size.y
		)
		sprite.scale = scale_factor

class_name Option
extends AspectRatioContainer

var control:CenterContainer
var BG:Button
@export var texture:Texture2D
@export var action:ActionData
var sprite:Sprite2D

var is_dragging:bool
var drag_ofset:Vector2

var check_parent
var original_parent: Node

func _ready() -> void:
	is_dragging =false
	drag_ofset =Vector2.ZERO
	
	check_parent =get_parent()
	original_parent =get_parent()
	
	control =$CenterContainer
	BG =$CenterContainer/Button
	sprite =$CenterContainer/Control/Sprite2D
	sprite.texture = texture
	adjust_sprite_to_control()

func _process(delta: float) -> void:
	if is_dragging:
		self.global_position = get_global_mouse_position() + drag_ofset
		

func adjust_sprite_to_control():
	if sprite.texture:
		var control_size = control.size
		var texture_size = sprite.texture.get_size()
		var scale_factor = Vector2(
			control_size.y / texture_size.y,
			control_size.y / texture_size.y
		)
		sprite.scale = scale_factor	

func _on_button_down() -> void:
	#Button was pressed
	z_index =5
	is_dragging =true
	drag_ofset = self.global_position - get_global_mouse_position()
	
	original_parent =get_parent()
	
func _on_button_up() -> void:
	#Button was released
	z_index =0
	if check_parent is CenterContainer:
		perform_swap_check()
	
	reparent(check_parent)
	check_parent.queue_sort()
	is_dragging =false

func perform_swap_check():
	for child in check_parent.get_children():
		if child is Option and child != self:
			child.reparent(original_parent)
			original_parent.queue_sort()
			break
			
	

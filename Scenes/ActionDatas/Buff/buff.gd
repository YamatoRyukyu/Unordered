extends "res://Scripts/action.gd"

var follow: Node =self
var duration: int =2
var dist_to_follow: Vector2 =Vector2.ZERO
var base_size: Vector2 =Vector2(1.0, 1.0)

func _ready() -> void:
	super._ready()
	if get_tree().root.get_node("Game/Player"):
		follow =get_tree().root.get_node("Game/Player")
		dist_to_follow =Vector2(-30, -30)
		global_position =follow.global_position +dist_to_follow
	
func _physics_process(delta: float) -> void:
	global_rotation =0.0
	if follow:
		global_position =follow.global_position +dist_to_follow
	
	if base_size != scale:
		scale =base_size
	
func _on_player_change_action(new_index: int):
	if new_index ==0:
		queue_free()
		return
		
	duration -=1
	if duration <=0:
		queue_free()

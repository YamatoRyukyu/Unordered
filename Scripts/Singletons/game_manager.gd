extends Node

var title_scene: PackedScene = preload("res://Scenes/GameSequence/title.tscn")
var prepare_scene: PackedScene = preload("res://Scenes/GameSequence/preparation.tscn")
var game_scene: PackedScene = preload("res://Scenes/GameSequence/survive_game.tscn")
var game_over_scene: PackedScene = preload("res://Scenes/GameSequence/result.tscn")

var save_res_path: String ="res://Datas/SaveData.tres"

var player_actions:Array[ActionData]
@export var player_action_len: int

var survive_time:int
var last_level:int

func _ready() -> void:
	player_action_len =3
	survive_time =0
	last_level =0

func load_prepare_scene():
	get_tree().change_scene_to_packed(prepare_scene)
	
func load_game_scene():
	get_tree().change_scene_to_packed(game_scene)

func load_game_over_scene():
	get_tree().change_scene_to_packed(game_over_scene)

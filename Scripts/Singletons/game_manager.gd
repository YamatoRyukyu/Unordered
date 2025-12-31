extends Node

var title_scene: PackedScene = preload("res://Scenes/GameSequence/title.tscn")
var prepare_scene: PackedScene = preload("res://Scenes/GameSequence/preparation.tscn")
var game_scene: PackedScene = preload("res://Scenes/GameSequence/survive_game.tscn")

var player_actions:Array[ActionData]
@export var player_action_len: int

func _ready() -> void:
	player_action_len =3

func load_prepare_scene():
	get_tree().change_scene_to_packed(prepare_scene)
	
func load_game_scene():
	get_tree().change_scene_to_packed(game_scene)

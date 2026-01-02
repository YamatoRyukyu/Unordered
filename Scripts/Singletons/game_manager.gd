extends Node

var title_scene_path: String = "res://Scenes/GameSequence/title.tscn"
var prepare_scene_path: String = "res://Scenes/GameSequence/preparation.tscn"
var game_scene_path: String = "res://Scenes/GameSequence/survive_game.tscn"
var game_over_scene_path: String = "res://Scenes/GameSequence/result.tscn"
var upgrade_scene_path: String = "res://Scenes/UpgradeScreen/upgrade_screen.tscn"

var save_res_path: String ="res://Datas/SaveData.tres"
var save_res: SaveData

var player_actions:Array[ActionData]
@export var player_action_len: int

var survive_time:int
var last_level:int
var resource:int

func _ready() -> void:
	player_action_len =3
	survive_time =0
	last_level =0
	load_save_data()

func load_title_scene():
	var title_scene: PackedScene =load(title_scene_path)
	get_tree().change_scene_to_packed(title_scene)

func load_prepare_scene():
	var prepare_scene: PackedScene =load(prepare_scene_path)
	get_tree().change_scene_to_packed(prepare_scene)
	
func load_game_scene():
	var game_scene: PackedScene =load(game_scene_path)	
	get_tree().change_scene_to_packed(game_scene)

func load_game_over_scene():
	var game_over_scene: PackedScene =load(game_over_scene_path)
	get_tree().change_scene_to_packed(game_over_scene)
	
func load_upgrade_scene():
	var upgrade_scene: PackedScene =load(upgrade_scene_path)
	get_tree().change_scene_to_packed(upgrade_scene)	

func load_save_data():
	save_res =load(save_res_path)

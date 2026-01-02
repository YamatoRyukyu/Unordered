extends Node

var title_scene_path: String = "res://Scenes/GameSequence/title.tscn"
var prepare_scene_path: String = "res://Scenes/GameSequence/preparation.tscn"
var game_scene_path: String = "res://Scenes/GameSequence/survive_game.tscn"
var game_over_scene_path: String = "res://Scenes/GameSequence/result.tscn"
var upgrade_scene_path: String = "res://Scenes/UpgradeScreen/upgrade_screen.tscn"

var inited_save_res_path: String ="res://Datas/InitedSaveData.tres"
var save_res_path: String ="user://SaveData.tres"
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
	get_tree().change_scene_to_file(title_scene_path)

func load_prepare_scene():
	get_tree().change_scene_to_file(prepare_scene_path)
	
func load_game_scene():
	get_tree().change_scene_to_file(game_scene_path)

func load_game_over_scene():
	get_tree().change_scene_to_file(game_over_scene_path)

func load_upgrade_scene():
	get_tree().change_scene_to_file(upgrade_scene_path)

func load_save_data():
	if ResourceLoader.exists(save_res_path):
		save_res =ResourceLoader.load(save_res_path) as SaveData
	else :
		init_save_data()
	
func save_game_data():
	ResourceSaver.save(save_res, save_res_path)

func init_save_data():
	if ResourceLoader.exists(inited_save_res_path):
		var template_data = ResourceLoader.load(inited_save_res_path)
		save_res =template_data.duplicate(true)
	else :
		save_res =SaveData.new()

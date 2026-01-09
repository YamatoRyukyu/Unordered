extends Node

@export var enemy_scenes: Array[PackedScene]
@onready var game_world =get_parent()

func spawn(spawn_position: Vector2, player_level: int) -> void:
	if enemy_scenes.is_empty():
		return
	
	var selected_enemy_scene: PackedScene
	if player_level <5:
		selected_enemy_scene =enemy_scenes[0]
	elif player_level <10:
		selected_enemy_scene =enemy_scenes[1]
	else :
		selected_enemy_scene =enemy_scenes.pick_random()
	
	var enemy: Node =selected_enemy_scene.instantiate()
	enemy.global_position =spawn_position
	
	if enemy.has_method("setup_enemy"):
		enemy.setup_enemy(player_level)
	
	game_world.add_child(enemy)

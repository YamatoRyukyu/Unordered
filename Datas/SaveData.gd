@tool
extends Resource
class_name SaveData

@export var upgrade_resource: int =0

@export var action_resources_path: Array[String] =[
	"res://Scenes/ActionDatas/Bomb/Bomb.tres",
	"res://Scenes/ActionDatas/Canon/canon.tres",
	"res://Scenes/ActionDatas/SwingSword/sword.tres",
	"res://Scenes/ActionDatas/Bullet/bullet.tres",
	"res://Scenes/ActionDatas/Buff/buff.tres",
	"res://Scenes/ActionDatas/Broom/broom.tres",
]

@export var action_resource_dicts: Array[Dictionary]
#path, name, is_unlocked

@export var upgrades: Dictionary ={
	"health" :1,
	"power" :1,
	"speed": 1,
}


func init_action_dictionary():
	action_resource_dicts.clear()
	for path in action_resources_path:
		var dict: Dictionary =ActionResourceDict.name_from_path(path)
		action_resource_dicts.append(dict)

func is_action_unlocked(action_name: String) -> bool:
	for action in action_resource_dicts:
		if action.name == action_name:
			return action.is_unlocked 
	return false

func unlock_action(action_name: String):
	for action in action_resource_dicts:
		if action["name"] == action_name:
			action["is_unlocked"] =true
			print(action.name,"unlocked")
			return
	return
			
func lock_acion(action_name: String):
	for action in action_resource_dicts:
		if action["name"] == action_name:
			action["is_unlocked"] =false
			return
	return
	

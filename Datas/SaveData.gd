@tool
extends Resource
class_name SaveData

@export var action_resources: Array[Dictionary] =[
	{
		"path": "res://Scenes/ActionDatas/Bomb/Bomb.tres",
		"is_unlocked": true
	},
	{
		"path": "res://Scenes/ActionDatas/Canon/canon.tres",
		"is_unlocked": true
	},
	{
		"path": "res://Scenes/ActionDatas/SwingSword/sword.tres",
		"is_unlocked": true	
	}
]

@export var upgrades: Dictionary ={
	"health" :2,
	"damage" :2,
	"speed": 2,
}

func init_action_resources_lock():
	for dict in action_resources:
		var action_resource: ActionData =load(dict["path"])
		action_resource.is_unlocked =dict["is_unlocked"]

func unlock_action(action_path: String):
	for action in action_resources:
		if action["path"] == action_path:
			action["is_unlocked"] =true
			return

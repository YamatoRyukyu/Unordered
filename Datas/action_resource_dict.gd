class_name ActionResourceDict

static func name_from_path(got_path: String) ->Dictionary:
	var action_resource: ActionData =load(got_path)
	if not action_resource:
		return {"path": got_path, "name": "Error", "is_unlocked": false}
	
	return{
		"path": got_path,
		"name": action_resource.name,
		"is_unlocked": false
	}

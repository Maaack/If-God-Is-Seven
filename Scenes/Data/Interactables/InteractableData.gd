extends Resource


class_name InteractableData

enum interaction_types{LOOK, LISTEN, SMELL, SPEAK, USE, GRAB, TRAVEL}


export(String) var title : String
export(PackedScene) var look_event : PackedScene
export(PackedScene) var listen_event : PackedScene
export(PackedScene) var smell_event : PackedScene
export(PackedScene) var use_event : PackedScene
export(Array, Resource) var conditions : Array

var age_in_minutes : int = 0

func add_time(minutes : int):
	age_in_minutes += minutes

func get_event_scene(interaction_type : int):
	match(interaction_type):
		interaction_types.LOOK:
			return look_event
		interaction_types.LISTEN:
			return listen_event
		interaction_types.SMELL:
			return smell_event
		interaction_types.USE:
			return use_event

func has_event_scene(interaction_type : int):
	var event_scene : PackedScene = get_event_scene(interaction_type)
	return event_scene != null

func get_event_ui(interaction_type : int):
	var event_scene : PackedScene = get_event_scene(interaction_type)
	if event_scene == null:
		return
	var event_ui = event_scene.instance()
	if event_ui == null:
		return
	event_ui.source_interactable = self
	return event_ui

func _concat_three_or_more(list : Array) -> String:
	var all_conditions : String = ""
	for i in conditions.size():
		var condition : ConditionData = conditions[i]
		var condition_string : String = str(condition)
		if i == conditions.size() - 1:
			all_conditions += "and %s" % [condition_string]
		else:
			all_conditions += "%s, " % [condition_string]
	return all_conditions

func get_filtered_conditions(interaction_type : int) -> Array:
	var filtered_conditions : Array = []
	for condition in conditions:
		if condition is ConditionData:
			match(interaction_type):
				interaction_types.LOOK:
					if condition.can_look:
						filtered_conditions.append(condition)
				interaction_types.LISTEN:
					if condition.can_listen:
						filtered_conditions.append(condition)
				interaction_types.SMELL:
					if condition.can_smell:
						filtered_conditions.append(condition)
				interaction_types.USE:
					if condition.can_feel:
						filtered_conditions.append(condition)
	return filtered_conditions

func get_conditions_string(interaction_type : int) -> String:
	var filtered_conditions : Array = get_filtered_conditions(interaction_type)
	match(filtered_conditions.size()):
		0:
			return ""
		1:
			return "%s" % [str(filtered_conditions[0])]
		2:
			return "%s and %s" % [str(filtered_conditions[0]), str(filtered_conditions[1])]
		_:
			return _concat_three_or_more(filtered_conditions)
		


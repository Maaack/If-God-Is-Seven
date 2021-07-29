extends Resource


class_name InteractableData

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
		InteractionConstants.interaction_types.LOOK:
			return look_event
		InteractionConstants.interaction_types.LISTEN:
			return listen_event
		InteractionConstants.interaction_types.SMELL:
			return smell_event
		InteractionConstants.interaction_types.USE:
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
	event_ui.interaction_type = interaction_type
	return event_ui

func get_condition_by_adjective(match_adjective : String):
	for condition in conditions:
		if condition is ConditionData:
			if condition.adjective == match_adjective:
				return condition
	return null

func has_condition(match_adjective : String, min_intensity : int = 1, max_intensity : int = 16) -> bool:
	var condition : ConditionData = get_condition_by_adjective(match_adjective)
	if condition is ConditionData:
		if condition.intensity >= min_intensity and condition.intensity <= max_intensity:
			return true
	return false

func set_condition(new_condition : ConditionData):
	var old_condition : ConditionData = get_condition_by_adjective(new_condition.adjective)
	if old_condition is ConditionData:
		old_condition.intensity = new_condition.intensity
	else:
		conditions.append(new_condition)

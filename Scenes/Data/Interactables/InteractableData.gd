tool
extends Resource


class_name InteractableData

export(String) var title : String
export(PackedScene) var interaction_event : PackedScene
export(Array, InteractionConstants.interaction_types) var interactions_array : Array = [
	InteractionConstants.interaction_types.LOOK,
	InteractionConstants.interaction_types.LISTEN,
	InteractionConstants.interaction_types.SMELL,
	InteractionConstants.interaction_types.FEEL,
]
export(Array, Resource) var conditions : Array
export var scene_position : Vector2

var age_in_minutes : int = 0
var interaction_count : int = 0
var interactions_had_array : Array = []

func add_time(minutes : int):
	age_in_minutes += minutes

func is_interactable(interaction_type : int):
	return interaction_type in interactions_array

func has_interacted(interaction_type : int):
	return interaction_type in interactions_had_array

func add_interaction_type(interaction_type : int):
	if is_interactable(interaction_type):
		return
	interactions_array.append(interaction_type)

func remove_interaction_type(interaction_type : int):
	if not is_interactable(interaction_type):
		return
	interactions_array.erase(interaction_type)

func get_event_ui(interaction_type : int):
	if not is_interactable(interaction_type):
		return
	if interaction_event == null:
		return
	var event_ui = interaction_event.instance()
	if event_ui == null:
		return
	interaction_count += 1
	if not has_interacted(interaction_type):
		interactions_had_array.append(interaction_type)
	return event_ui

func get_conditions() -> Array:
	return conditions

func get_condition_by_adjective(match_adjective : String):
	return ConditionData.match_adjective_in_conditions(match_adjective, get_conditions())

func set_condition(new_condition : ConditionData):
	var old_condition : ConditionData = get_condition_by_adjective(new_condition.adjective)
	if old_condition is ConditionData:
		old_condition.intensity = new_condition.intensity
	else:
		conditions.append(new_condition)

func get_filtered_conditions(interaction_type : int) -> Array:
	var filtered_conditions : Array = []
	for condition in get_conditions():
		if condition is ConditionData:
			if condition.intensity == 0:
				continue
			if condition.is_interactable(interaction_type):
				filtered_conditions.append(condition)
	return filtered_conditions

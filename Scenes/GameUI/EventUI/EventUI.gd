extends Control


class_name EventUI

signal attempted_waiting(minutes)
signal added_historical_note(note)
signal ended_event

onready var title_label = $EventPanel/MarginContainer/Control/VBoxContainer/TitleLabel
onready var body_label = $EventPanel/MarginContainer/Control/VBoxContainer/HBoxContainer/BodyLabel
onready var body_texture_node = $EventPanel/MarginContainer/Control/VBoxContainer/HBoxContainer/BodyTextureRect
onready var continue_button = $EventPanel/MarginContainer/Control/VBoxContainer/HBoxContainer2/ContinueButton

var init_body_text : String
var interaction_type : int
var source_interactable : InteractableData setget set_source_interactable

func set_source_interactable(value : InteractableData):
	source_interactable = value

func get_title_text():
	return title_label.text

func get_body_text():
	return body_label.text

func get_body_texture():
	return body_texture_node.texture

func hide_continue_button():
	continue_button.hide()

func show_continue_button():
	continue_button.show()

func end_event():
	emit_signal("ended_event")
	queue_free()

func _on_ContinueButton_pressed():
	queue_free()

func _ready():
	init_body_text = body_label.text

func get_interaction_type():
	return interaction_type

func get_source_interactive_conditions() -> Array:
	var filtered_conditions : Array = []
	for condition in source_interactable.get_conditions():
		if condition is ConditionData:
			if condition.intensity == 0:
				continue
			if condition.can_interact(interaction_type):
				filtered_conditions.append(condition)
	return filtered_conditions

func get_source_condition_by_adjective(adjective : String):
	return source_interactable.get_condition_by_adjective(adjective)

func _alter_source_condition(condition : ConditionData, intensity_delta : int, min_limit : int = -1,  max_limit : int = -1):
	if max_limit < 0:
		max_limit = condition.intensity_adverbs.size() - 1
	if min_limit < 0:
		min_limit = 0
	var match_condition = get_source_condition_by_adjective(condition.adjective)
	if match_condition == null:
		match_condition = condition.duplicate()
	if (intensity_delta < 0 and match_condition.intensity <= min_limit) or \
		(intensity_delta > 0 and match_condition.intensity >= max_limit):
		return false
	match_condition.intensity += intensity_delta
	source_interactable.set_condition(match_condition)
	return true

func _get_source_condition_or_new(condition : ConditionData):
	var match_condition : ConditionData = get_source_condition_by_adjective(condition.adjective)
	if match_condition == null:
		return condition.duplicate()
	return match_condition

func _concat_three_or_more(conditions : Array) -> String:
	var all_conditions : String = ""
	for i in conditions.size():
		var condition : ConditionData = conditions[i]
		var condition_string : String = str(condition)
		if i == conditions.size() - 1:
			all_conditions += "and %s" % [condition_string]
		else:
			all_conditions += "%s, " % [condition_string]
	return all_conditions

func get_source_conditions_string() -> String:
	var filtered_conditions : Array = get_source_interactive_conditions()
	match(filtered_conditions.size()):
		0:
			return ""
		1:
			return "%s" % [str(filtered_conditions[0])]
		2:
			return "%s and %s" % [str(filtered_conditions[0]), str(filtered_conditions[1])]
		_:
			return _concat_three_or_more(filtered_conditions)

func get_interaction_verb() -> String:
	match(get_interaction_type()):
		InteractionConstants.interaction_types.LOOK:
			return 'looks'
		InteractionConstants.interaction_types.LISTEN:
			return 'sounds'
		InteractionConstants.interaction_types.SMELL:
			return 'smells'
		InteractionConstants.interaction_types.FEEL:
			return 'feels'
		InteractionConstants.interaction_types.USE:
			return 'feels'
		_:
			return ''
